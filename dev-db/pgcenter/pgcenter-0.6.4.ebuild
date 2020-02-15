# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=( "github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/jehiah/go-strftime 1d33003b3869"
	"github.com/jroimartin/gocui v0.4.0"
	"github.com/lib/pq v1.0.0"
	"github.com/mattn/go-runewidth v0.0.3"
	"github.com/nsf/termbox-go b66b20ab708e"
	"github.com/pkg/errors v0.8.0"
	"github.com/spf13/cobra v0.0.3"
	"github.com/spf13/pflag v1.0.2"
	"golang.org/x/crypto 0e37d006457b github.com/golang/crypto"
	"golang.org/x/sys ee1b12c67af4 github.com/golang/sys" )

EGO_PN="github.com/lesovsky/${PN}"

inherit go-module

DESCRIPTION="Command-line admin tool for observing and troubleshooting Postgres"
HOMEPAGE="https://github.com/lesovsky/pgcenter"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(go-module_vendor_uris)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	export -n GOCACHE XDG_CACHE_HOME
	go build || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin pgcenter
}

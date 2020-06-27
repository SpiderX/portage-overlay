# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/inconshreveable/mousetrap v1.0.0/go.mod"
	"github.com/jehiah/go-strftime v0.0.0-20171201141054-1d33003b3869"
	"github.com/jehiah/go-strftime v0.0.0-20171201141054-1d33003b3869/go.mod"
	"github.com/jroimartin/gocui v0.4.0"
	"github.com/jroimartin/gocui v0.4.0/go.mod"
	"github.com/lib/pq v1.0.0"
	"github.com/lib/pq v1.0.0/go.mod"
	"github.com/mattn/go-runewidth v0.0.3"
	"github.com/mattn/go-runewidth v0.0.3/go.mod"
	"github.com/nsf/termbox-go v0.0.0-20180819125858-b66b20ab708e"
	"github.com/nsf/termbox-go v0.0.0-20180819125858-b66b20ab708e/go.mod"
	"github.com/pkg/errors v0.8.0"
	"github.com/pkg/errors v0.8.0/go.mod"
	"github.com/spf13/cobra v0.0.3"
	"github.com/spf13/cobra v0.0.3/go.mod"
	"github.com/spf13/pflag v1.0.2"
	"github.com/spf13/pflag v1.0.2/go.mod"
	"golang.org/x/crypto v0.0.0-20180910181607-0e37d006457b"
	"golang.org/x/crypto v0.0.0-20180910181607-0e37d006457b/go.mod"
	"golang.org/x/sys v0.0.0-20180918153733-ee1b12c67af4"
	"golang.org/x/sys v0.0.0-20180918153733-ee1b12c67af4/go.mod"
	)
go-module_set_globals

DESCRIPTION="Command-line admin tool for observing and troubleshooting Postgres"
HOMEPAGE="https://github.com/lesovsky/pgcenter"
SRC_URI="https://github.com/lesovsky/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	go build -ldflags "-X github.com/lesovsky/pgcenter/cmd.gitTag=${PV}
		-X github.com/lesovsky/pgcenter/cmd.gitCommit=${PV}
		-X github.com/lesovsky/pgcenter/cmd.gitBranch=${PV}" \
		|| die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin pgcenter
}

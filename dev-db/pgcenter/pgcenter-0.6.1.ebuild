# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=( "github.com/inconshreveable/mousetrap 76626ae9c91c4f2a10f34cad8ce83ea42c93bb75"
	"github.com/jehiah/go-strftime 1d33003b386959af197ba96475f198c114627b5e"
	"github.com/jmoiron/sqlx d161d7a76b5661016ad0b085869f77fd410f3e6a"
	"github.com/jroimartin/gocui c055c87ae801372cd74a0839b972db4f7697ae5f"
	"github.com/lib/pq 4ded0e9383f75c197b3a2aaa6d590ac52df6fd79"
	"github.com/mattn/go-runewidth ce7b0b5c7b45a81508558cd1dba6bb1e4ddb51bb"
	"github.com/nsf/termbox-go b66b20ab708e289ff1eb3e218478302e6aec28ce"
	"github.com/pkg/errors 645ef00459ed84a119197bfb8d8205042c6df63d"
	"github.com/spf13/cobra ef82de70bb3f60c65fb8eebacbb2d122ef517385"
	"github.com/spf13/pflag 9a97c102cda95a86cec2345a6f09f55a939babf5" )

EGO_PN="github.com/lesovsky/${PN}"

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Command-line admin tool for observing and troubleshooting Postgres"
HOMEPAGE="https://github.com/lesovsky/pgcenter"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-go/go-crypto:=
	dev-go/go-sys:="
RDEPEND="${DEPEND}"

DOCS=( src/"${EGO_PN}"/README.md )

src_install() {
	einstalldocs
	dobin pgcenter
}

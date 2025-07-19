# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

COMMIT="3ece0ff8ae49ea72485e4aad14926e9251a8b1dc"
EGO_SUM=(
	"github.com/Knetic/govaluate v3.0.0+incompatible"
	"github.com/Knetic/govaluate v3.0.0+incompatible/go.mod"
	"github.com/eiannone/keyboard v0.0.0-20200508000154-caf4b762e807"
	"github.com/eiannone/keyboard v0.0.0-20200508000154-caf4b762e807/go.mod"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/mattn/go-runewidth v0.0.13"
	"github.com/mattn/go-runewidth v0.0.13/go.mod"
	"github.com/nsf/termbox-go v1.1.1"
	"github.com/nsf/termbox-go v1.1.1/go.mod"
	"github.com/rivo/uniseg v0.2.0"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"golang.org/x/sys v0.1.0"
	"golang.org/x/sys v0.1.0/go.mod"
	)
go-module_set_globals

DESCRIPTION="Stock market tracker for hackers"
HOMEPAGE="https://github.com/mop-tracker/mop"
SRC_URI="https://github.com/mop-tracker/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz
	${EGO_SUM_SRC_URI}"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	ego build -o mop ./cmd/...
}

src_install() {
	einstalldocs
	dobin mop
}

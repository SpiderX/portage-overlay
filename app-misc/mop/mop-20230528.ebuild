# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

COMMIT="c9326191c769c230a56fd7eab7ea699fae00c858"

EGO_SUM=(
	"github.com/Knetic/govaluate v3.0.0+incompatible"
	"github.com/Knetic/govaluate v3.0.0+incompatible/go.mod"
	"github.com/eiannone/keyboard v0.0.0-20200508000154-caf4b762e807"
	"github.com/eiannone/keyboard v0.0.0-20200508000154-caf4b762e807/go.mod"
	"github.com/mattn/go-runewidth v0.0.9"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/mattn/go-runewidth v0.0.13"
	"github.com/mattn/go-runewidth v0.0.13/go.mod"
	"github.com/nsf/termbox-go v0.0.0-20201124104050-ed494de23a00"
	"github.com/nsf/termbox-go v0.0.0-20201124104050-ed494de23a00/go.mod"
	"github.com/nsf/termbox-go v1.1.1"
	"github.com/nsf/termbox-go v1.1.1/go.mod"
	"github.com/rivo/uniseg v0.2.0"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"golang.org/x/sys v0.0.0-20220319134239-a9b59b0215f8"
	"golang.org/x/sys v0.0.0-20220319134239-a9b59b0215f8/go.mod"
	)
go-module_set_globals

DESCRIPTION="Stock market tracker for hackers"
HOMEPAGE="https://github.com/mop-tracker/mop"
SRC_URI="https://github.com/mop-tracker/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${PN}-${COMMIT}"

src_compile() {
	ego build -buildmode=pie -trimpath -o mop ./cmd/...
}

src_install() {
	einstalldocs
	dobin mop
}

# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=( "github.com/SpiderX/portage-empty 3f4db1eb10e4dc42584b6b3df23f037904e6ea07"
"github.com/docopt/docopt-go 784ddc588536785e7299f7272f39101f7faccc3f"
"github.com/fatih/color 570b54cabe6b8eb0bc2dfce68d964677d63b5260"
"github.com/mattn/go-colorable 167de6bfdfba052fa6b2d3664c8f5272e23c9072"
"github.com/mattn/go-isatty 0360b2af4f38e8d38c7fce2a9f4e702702d73a39"
"github.com/tidwall/gjson 5a69e67cfd8f6f9b0044ed49f5079d0eeed28653"
"github.com/tidwall/match 1731857f09b1f38450e2c12409748407822dc6be" )

EGO_PN="github.com/koenbollen/${PN}"
EGIT_REPO_URI="https://github.com/koenbollen/${PN}.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/${P}/src/${EGO_PN}"

inherit git-r3 golang-build golang-vcs-snapshot

DESCRIPTION="A tool for working with structured JSON logging"
HOMEPAGE="https://github.com/koenbollen/jl"
SRC_URI="${EGO_VENDOR_URI}"

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-go/go-sys:="
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
	golang-vcs-snapshot_src_unpack
}

src_test() {
	GOPATH="${S}" go test -v -work -x ./... \
		|| die "tests failed"
}

src_install() {
	einstalldocs
	dobin jl
}

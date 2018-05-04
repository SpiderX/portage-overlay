# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=( "github.com/BurntSushi/toml b26d9c308763d68093482582cea63d69be07a0f0"
	"github.com/anaskhan96/soup cd07662ec9300d16d2ece1c24b0b29ad89f65ff4"
	"github.com/fatih/color 507f6050b8568533fb3f5504de8e5205fa62a114"
	"github.com/mattn/go-colorable 167de6bfdfba052fa6b2d3664c8f5272e23c9072"
	"github.com/mattn/go-isatty 0360b2af4f38e8d38c7fce2a9f4e702702d73a39"
	"github.com/mattn/go-runewidth 9e777a8366cce605130a531d2cd6363d07ad7317"
	"github.com/miguelmota/go-coinmarketcap 42269f499a7031e0affa526258909fa73f2914cd"
	"github.com/nsf/termbox-go 7cbfaac9e282b3ea0cefeddc67b2c3ed3aaf97bc"
	"github.com/go4org/go4 9599cf28b011184741f249bd9f9330756b506cbc" )

EGO_PN="github.com/miguelmota/${PN}"

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Interactive cryptocurrency monitor"
HOMEPAGE="https://github.com/miguelmota/cointop"
SRC_URI="https://${EGO_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# dev-go/toml doesn't provide sources
DEPEND="dev-lang/go:=
	dev-go/go-net:=
	dev-go/go-sys:="
RDEPEND="${DEPEND}"

src_prepare() {
	default

	# Use vendored package
	sed  -i 's|go4.org|github.com/go4org/go4|' src/"${EGO_PN}"/pkg/slice/slice.go \
		|| die "sed failed for slice.go"

	# Remove bundled libs to use provided by portage
	rm -rf src/"${EGO_PN}"/vendor/go4.org || die "failed to remove go4.org"
	rm -rf src/"${EGO_PN}"/vendor/golang.org || die "failed to remove golang.org"
}

src_install() {
	dobin cointop
}

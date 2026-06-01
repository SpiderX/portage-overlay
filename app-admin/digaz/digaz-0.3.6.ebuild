# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Look up region and other information for any Azure IP address"
HOMEPAGE="https://github.com/sampointer/digaz"
SRC_URI="https://github.com/sampointer/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
PROPERTIES="test_network"

src_compile() {
	ego build
}

src_test() {
	ego test -work ./... -skip TestLookup/looks_up_IPv4_address
}

src_install() {
	einstalldocs
	dobin digaz
}

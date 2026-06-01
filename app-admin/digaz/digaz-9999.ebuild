# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Look up region and other information for any Azure IP address"
HOMEPAGE="https://github.com/sampointer/digaz"
EGIT_REPO_URI="https://github.com/sampointer/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

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

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/sampointer/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Look up region and other information for any AWS IP address"
HOMEPAGE="https://github.com/sampointer/digaws"

LICENSE="Apache-2.0"
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
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin digaws
}

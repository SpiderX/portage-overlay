# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/sampointer/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Look up region and other information for any AWS IP address"
HOMEPAGE="https://github.com/sampointer/digaws"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="test" # needs net

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin digaws
}

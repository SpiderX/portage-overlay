# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Tool for writing Linux pipes with instant live preview"
HOMEPAGE="https://github.com/akavel/up"
EGIT_REPO_URI="https://github.com/akavel/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build
}

src_test() {
	ego test
}

src_install() {
	einstalldocs
	dobin up
}

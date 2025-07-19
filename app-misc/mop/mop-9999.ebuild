# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Stock market tracker for hackers"
HOMEPAGE="https://github.com/mop-tracker/mop"
EGIT_REPO_URI="https://github.com/mop-tracker/${PN}.git"

LICENSE="MIT"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build -o mop ./cmd/...
}

src_install() {
	einstalldocs
	dobin mop
}

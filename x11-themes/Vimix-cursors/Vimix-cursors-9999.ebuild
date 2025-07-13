# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Vimix-cursors for linux desktop"
HOMEPAGE="https://github.com/vinceliuice/Vimix-cursors"
EGIT_REPO_URI="https://github.com/vinceliuice/${PN}.git"

LICENSE="GPL-3"
SLOT="0"

BDEPEND="media-gfx/inkscape
	x11-apps/xcursorgen"

src_compile() {
	./build.sh || die "build failed"
}

src_install() {
	insinto /usr/share/icons/Vimix-cursors
	doins -r dist/.
	insinto /usr/share/icons/Vimix-cursors-white
	doins -r dist-white/.
}

# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/vinceliuice/${PN}.git"

inherit git-r3

DESCRIPTION="Vimix-cursors for linux desktop"
HOMEPAGE="https://github.com/vinceliuice/Vimix-cursors"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

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

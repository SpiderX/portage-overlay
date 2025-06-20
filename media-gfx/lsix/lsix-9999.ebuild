# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Image viewer for terminal that use sixel graphics"
HOMEPAGE="https://github.com/hackerb9/lsix"
EGIT_REPO_URI="https://github.com/hackerb9/${PN}.git"

LICENSE="GPL-3+"
SLOT="0"
IUSE="djvu jpeg jpeg2k png svg tiff webp"

RDEPEND="media-gfx/imagemagick[truetype,djvu?,jpeg?,jpeg2k?,png?,svg?,tiff?,webp?]"

src_install() {
	einstalldocs
	dobin lsix
}

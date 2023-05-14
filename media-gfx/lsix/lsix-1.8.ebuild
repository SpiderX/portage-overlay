# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Image viewer for terminal that use sixel graphics"
HOMEPAGE="https://github.com/hackerb9/lsix"
SRC_URI="https://github.com/hackerb9/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="djvu jpeg jpeg2k png svg tiff webp"

RDEPEND="media-gfx/imagemagick[truetype,djvu?,jpeg?,jpeg2k?,png?,svg?,tiff?,webp?]"

src_install() {
	einstalldocs
	dobin lsix
}

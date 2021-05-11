# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit dune

DESCRIPTION="An image manipulation library for ocaml"
HOMEPAGE="https://gitlab.com/camlspotter/camlimages"
SRC_URI="https://gitlab.com/camlspotter/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-2-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="exif gif gtk jpeg +ocamlopt png postscript tiff truetype X xpm"

RDEPEND="dev-lang/ocaml:=[ocamlopt?]
	exif? ( media-libs/libexif )
	gif? ( media-libs/giflib:0= )
	gtk? ( dev-ml/lablgtk:2= )
	jpeg? ( virtual/jpeg:= )
	tiff? ( media-libs/tiff )
	png? ( media-libs/libpng:= )
	postscript? ( app-text/ghostscript-gpl )
	truetype? ( media-libs/freetype:2 )
	xpm? ( x11-libs/libXpm )
	X? ( x11-apps/rgb )
	sys-libs/zlib:="
DEPEND="${DEPEND}
	dev-ml/stdio:="
BDEPEND="dev-ml/dune-configurator:=
	virtual/pkgconfig"

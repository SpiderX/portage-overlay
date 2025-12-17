# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="An image manipulation library for ocaml"
HOMEPAGE="https://gitlab.com/camlspotter/camlimages"
SRC_URI="https://gitlab.com/camlspotter/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-2-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="exif gif gtk jpeg +ocamlopt png postscript tiff truetype X xpm"

RDEPEND="dev-ml/graphics:0=[ocamlopt?]
	dev-ml/lablgtk:2=[ocamlopt?]
	exif? ( media-libs/libexif )
	gif? ( media-libs/giflib:0= )
	jpeg? ( media-libs/libjpeg-turbo:0= )
	tiff? ( media-libs/tiff:0= )
	png? ( media-libs/libpng:0= )
	postscript? ( app-text/ghostscript-gpl:0= )
	truetype? ( media-libs/freetype:2 )
	xpm? ( x11-libs/libXpm )
	X? ( x11-apps/rgb )
	virtual/zlib:0="
DEPEND="${RDEPEND}
	dev-ml/stdio:="
BDEPEND="dev-ml/cppo
	dev-ml/dune-configurator
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${PN}"-5.0.5-fPIC.patch
	"${FILESDIR}/${PN}"-5.0.5-stdlib.patch )

# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/camlspotter/${PN}.git"

inherit dune git-r3

DESCRIPTION="An image manipulation library for ocaml"
HOMEPAGE="https://gitlab.com/camlspotter/camlimages"
SRC_URI=""

LICENSE="GPL-2-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="exif gif gtk jpeg +ocamlopt png postscript tiff truetype X xpm"

RDEPEND="exif? ( media-libs/libexif )
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
DEPEND="${RDEPEND}
	dev-ml/stdio:="
BDEPEND="dev-ml/cppo:0=
	dev-ml/dune-configurator:=
	virtual/pkgconfig"

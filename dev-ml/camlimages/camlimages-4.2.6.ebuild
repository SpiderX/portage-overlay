# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit findlib

DESCRIPTION="An image manipulation library for ocaml"
HOMEPAGE="http://gallium.inria.fr/camlimages"
SRC_URI="https://bitbucket.org/camlspotter/camlimages/get/${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-2-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="exif gif gtk jpeg png postscript tiff truetype X xpm"

RDEPEND="dev-lang/ocaml:=[X?,ocamlopt]
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
DEPEND="${DEPEND}"
BDEPEND="dev-util/omake
	dev-ml/findlib
	virtual/pkgconfig"

DOCS=( Changes.txt README.md )

src_compile() {
	omake   "$(usex exif ARG_WANT_EXIF= ARG_WANT_EXIT= 1 0 )" \
		"$(usex gif ARG_WANT_GIF= ARG_WANT_GIT= 1 0 )" \
		"$(usex png ARG_WANT_PNG= ARG_WANT_PNG= 1 0 )" \
		"$(usex jpeg ARG_WANT_JPEG= ARG_WANT_JPEG= 1 0 )" \
		"$(usex tiff ARG_WANT_TIFF= ARG_WANT_TIFF= 1 0 )" \
		"$(usex xpm ARG_WANT_XPM= ARG_WANT_XPM= 1 0 )" \
		"$(usex postscript ARG_WANT_GS= ARG_WANT_GS= 1 0 )" \
		"$(usex gtk ARG_WANT_GTK= ARG_WANT_GTK= 1 0 )" \
		"$(usex X ARG_WANT_GRAPHICS= ARG_WANT_GRAPHICS= 1 0 )" \
		"$(usex truetype ARG_WANT_FREETYPE= ARG_WANT_FREETYPE= 1 0 )" \
		PATH_FREETYPE_CONFIG=/bin/true \
		PATH_GS=/bin/true \
		--force-dotomake || die "omake compile failed"
}

src_install() {
	findlib_src_preinst
	omake --force-dotomake DESTDIR="${D}" install \
		|| die "omake install failed"
	einstalldocs
}

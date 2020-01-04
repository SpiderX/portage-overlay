# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit opam

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
BDEPEND="dev-ml/configurator:=
	dev-ml/jbuilder:=
	virtual/pkgconfig"

S="${WORKDIR}/camlspotter-camlimages-fc75238237a7"

DOCS=( Changes.txt README.md )

src_compile() {
	jbuilder build @install || die "build failed"
}

src_install() {
	opam_src_install camlimages
	einstalldocs
}

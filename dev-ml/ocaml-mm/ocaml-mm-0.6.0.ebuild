# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools findlib

DESCRIPTION="OCaml multimedia library"
HOMEPAGE="https://github.com/savonet/ocaml-mm"
SRC_URI="https://github.com/savonet/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="alsa ao +camlp4 debug ffmpeg gstreamer mad +ocamlopt ogg oss profiling pulseaudio sdl theora v4l"

RDEPEND="dev-lang/ocaml:=[ocamlopt?]
	dev-ml/ocamlsdl:=[ocamlopt?]
	alsa? ( dev-ml/ocaml-alsa:=[ocamlopt?] )
	ao? ( dev-ml/ocaml-ao:=[ocamlopt?] )
	camlp4? ( dev-ml/camlp4:=[ocamlopt?] )
	ffmpeg? ( dev-ml/ocaml-ffmpeg:=[ocamlopt?] )
	gstreamer? ( dev-ml/ocaml-gstreamer:=[ocamlopt?] )
	mad? ( dev-ml/ocaml-mad:=[ocamlopt?] )
	ogg? ( dev-ml/ocaml-ogg:=[ocamlopt?] )
	pulseaudio? ( dev-ml/ocaml-pulseaudio:=[ocamlopt?] )
	sdl? ( dev-ml/ocamlsdl:=[ocamlopt?] )
	theora? ( dev-ml/ocaml-theora:=[ocamlopt?] )"
DEPEND="${RDEPEND}
	dev-ml/findlib[ocamlopt?]
	virtual/pkgconfig"

DOCS=( {CHANGES,README}.md )

PATCHES=( "${FILESDIR}"/"${PN}"-0.3.0-configure.patch
	"${FILESDIR}"/"${PN}"-0.3.0-makefile.patch )

src_prepare() {
	default

	sed -i 's/AC_CHECK_TOOL_STRICT/AC_CHECK_TOOL/g' m4/ocaml.m4 \
		|| die "sed failed for m4/ocaml.m4"

	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	econf "$(use_enable alsa)" \
		"$(use_enable ao)" \
		"$(use_enable camlp4)" \
		"$(use_enable debug debugging)" \
		"$(use_enable ffmpeg)" \
		"$(use_enable gstreamer)" \
		"$(use_enable mad)" \
		"$(use_enable ocamlopt nativecode)" \
		"$(use_enable ogg)" \
		"$(use_enable oss)" \
		"$(use_enable profiling)" \
		"$(use_enable pulseaudio)" \
		"$(use_enable sdl)" \
		"$(use_enable theora)" \
		"$(use_enable v4l)"
}

src_install() {
	einstalldocs
	findlib_src_install
}

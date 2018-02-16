# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools findlib git-r3

DESCRIPTION="OCaml bindings to mm"
HOMEPAGE="https://github.com/savonet/ocaml-mm"
EGIT_REPO_URI="https://github.com/savonet/${PN}.git"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="alsa ao +camlp4 debug ffmpeg gstreamer mad +ocamlopt ogg oss profiling pulseaudio sdl theora v4l"

RDEPEND="dev-lang/ocaml:=[ocamlopt?]
	alsa? ( dev-ml/ocaml-alsa:= )
	ao? ( dev-ml/ocaml-ao:= )
	camlp4? ( dev-ml/camlp4:= )
	ffmpeg? ( dev-ml/ocaml-ffmpeg:= )
	gstreamer? ( dev-ml/ocaml-gstreamer:= )
	mad? ( dev-ml/ocaml-mad:= )
	ogg? ( dev-ml/ocaml-ogg:= )
	pulseaudio? ( dev-ml/ocaml-pulseaudio:= )
	sdl? ( dev-ml/ocamlsdl:= )
	theora? ( dev-ml/ocaml-theora:= )"
DEPEND="${RDEPEND}
	dev-ml/findlib
	virtual/pkgconfig"

DOCS=( CHANGES README )

PATCHES=( "${FILESDIR}"/"${P}"-configure.patch
	"${FILESDIR}"/"${P}"-makefile.patch )

src_prepare() {
	default

	sed -i 's/AC_CHECK_TOOL_STRICT/AC_CHECK_TOOL/g' m4/ocaml.m4 \
		|| die "Failed editing m4/ocaml.m4!"
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

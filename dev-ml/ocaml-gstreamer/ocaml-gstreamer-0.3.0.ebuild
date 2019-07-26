# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools findlib

DESCRIPTION="OCaml bindings to gstreamer"
HOMEPAGE="https://github.com/savonet/ocaml-gstreamer"
SRC_URI="https://github.com/savonet/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+camlp4 debug +ocamlopt profiling"

RDEPEND=">=dev-lang/ocaml-3.12.0:=[ocamlopt?]
	media-libs/gst-plugins-base:1.0
	media-libs/gstreamer:1.0
	camlp4? ( dev-ml/camlp4:= )"
DEPEND="${RDEPEND}
	>=dev-ml/findlib-0.8.1
	virtual/pkgconfig"

DOCS=( CHANGES README )
PATCHES=( "${FILESDIR}/${P}-loop.patch" )

src_prepare() {
	default

	sed -i 's/AC_CHECK_TOOL_STRICT/AC_CHECK_TOOL/g' m4/ocaml.m4 \
		|| die "Failed editing m4/ocaml.m4!"
	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	econf "$(use_enable camlp4)" \
		"$(use_enable debug debugging)" \
		"$(use_enable ocamlopt nativecode)" \
		"$(use_enable profiling)"
}

src_install() {
	einstalldocs
	findlib_src_install
}

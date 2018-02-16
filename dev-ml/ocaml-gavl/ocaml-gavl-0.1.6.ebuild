# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools findlib

DESCRIPTION="OCaml bindings to Gavl video manipulation library"
HOMEPAGE="https://github.com/savonet/ocaml-gavl"
SRC_URI="https://github.com/savonet/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+camlp4 debug +ocamlopt profiling"

RDEPEND="dev-lang/ocaml:=[ocamlopt?]
	media-libs/gavl
	camlp4? ( dev-ml/camlp4:= )"
DEPEND="${RDEPEND}
	dev-ml/findlib
	virtual/pkgconfig"

DOCS=( CHANGES README )

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

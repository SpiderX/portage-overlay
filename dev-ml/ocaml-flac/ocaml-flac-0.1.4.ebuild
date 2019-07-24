# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools findlib

DESCRIPTION="OCaml bindings to flac"
HOMEPAGE="https://github.com/savonet/ocaml-flac"
SRC_URI="https://github.com/savonet/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+camlp4 debug +ocamlopt ogg profiling"

RDEPEND=">=dev-lang/ocaml-4.03.0:=[ocamlopt?]
	>=media-libs/flac-1.2.1
	camlp4? ( dev-ml/camlp4:= )
	ogg? ( dev-ml/ocaml-ogg:= )"
DEPEND="${RDEPEND}
	>=dev-ml/findlib-0.8.1
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
		"$(use_enable profiling)" \
		"$(use_enable ocamlopt nativecode)" \
		"$(use_enable ogg)"
}

src_install() {
	einstalldocs
	findlib_src_install
}

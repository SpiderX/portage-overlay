# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit findlib

DESCRIPTION="OCaml bindings to Gavl video manipulation library"
HOMEPAGE="https://github.com/savonet/ocaml-gavl"
SRC_URI="https://api.github.com/repos/savonet/${PN}/tarball/a6ab72d -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-libs/gavl"

S="${WORKDIR}/savonet-${PN}-a6ab72d"

DOCS=( CHANGES README )

src_prepare() {
	default

	./bootstrap || die "bootstrap failed"
}

src_configure() {
	econf "$(use_enable ocamlopt nativecode)" --host=''
}

src_install() {
	einstalldocs
	findlib_src_install
}

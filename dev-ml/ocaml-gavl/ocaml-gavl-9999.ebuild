# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/savonet/${PN}.git"

inherit findlib git-r3

DESCRIPTION="OCaml bindings to Gavl video manipulation library"
HOMEPAGE="https://github.com/savonet/ocaml-gavl"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS=""

RDEPEND="media-libs/gavl"

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

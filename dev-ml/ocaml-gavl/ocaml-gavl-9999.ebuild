# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo findlib git-r3

DESCRIPTION="OCaml bindings to Gavl video manipulation library"
HOMEPAGE="https://github.com/savonet/ocaml-gavl"
EGIT_REPO_URI="https://github.com/savonet/${PN}.git"

LICENSE="GPL-2"
SLOT="0/${PV}"

RDEPEND="media-libs/gavl"

DOCS=( CHANGES README )

src_prepare() {
	default

	edo ./bootstrap
}

src_configure() {
	econf "$(use_enable ocamlopt nativecode)" --host=''
}

src_install() {
	einstalldocs
	findlib_src_install
}

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 opam virtualx

DESCRIPTION="Thin bindings to SDL for OCaml"
HOMEPAGE="https://github.com/dbuenzli/tsdl"
EGIT_REPO_URI="https://github.com/dbuenzli/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/ocaml-ctypes:0=[ocamlopt?]
	media-libs/libsdl2"
BDEPEND="dev-ml/topkg"

src_compile() {
	edo ocaml pkg/pkg.ml build --tests "$(usex test 'true' 'false')"
}

src_test() {
	virtx ocaml pkg/pkg.ml test
}

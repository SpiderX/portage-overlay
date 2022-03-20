# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/dbuenzli/${PN}.git"

inherit opam git-r3

DESCRIPTION="Thin bindings to SDL for OCaml"
HOMEPAGE="https://github.com/dbuenzli/tsdl"
SRC_URI=""

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/ocaml-ctypes:=[ocamlopt?]
	media-libs/libsdl2"
BDEPEND="dev-ml/topkg:="

src_compile() {
	ocaml pkg/pkg.ml build \
		--tests "$(usex test 'true' 'false')" \
		|| die "compile failed"
}

src_test() {
	ocaml pkg/pkg.ml test || die "test failed"
}

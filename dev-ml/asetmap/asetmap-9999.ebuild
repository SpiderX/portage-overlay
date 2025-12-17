# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 opam

DESCRIPTION="Alternative, compatible, OCaml standard library Sets and Maps"
HOMEPAGE="https://github.com/dbuenzli/asetmap"
EGIT_REPO_URI="https://github.com/dbuenzli/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

BDEPEND="dev-ml/findlib
	dev-ml/topkg"

src_compile() {
	edo ocaml pkg/pkg.ml build --tests "$(usex test 'true' 'false')"
}

src_test() {
	edo ocaml pkg/pkg.ml test
}

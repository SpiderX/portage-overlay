# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune edo git-r3

DESCRIPTION="An OCaml syntax extension for generating visitor classes"
HOMEPAGE="https://gitlab.inria.fr/fpottier/visitors"
EGIT_REPO_URI="https://gitlab.inria.fr/fpottier/visitors.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-ml/ppxlib-0.37:0=[ocamlopt?]
	dev-ml/ppx_deriving_yojson:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/cppo
		dev-ml/ocaml-hashcons
		dev-ml/ppx_import )"

src_test() {
	edo dune build test/snippets_basic.cma test/snippets_that_need_hashcons.cma \
		test/cil.cma test/ppx_import/snippets_that_need_ppx_import.cma \
		--profile release
}

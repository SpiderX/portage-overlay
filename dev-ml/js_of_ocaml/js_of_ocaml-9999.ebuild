# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="js_of_ocaml js_of_ocaml-compiler js_of_ocaml-lwt js_of_ocaml-ppx
	js_of_ocaml-ppx_deriving_json js_of_ocaml-toplevel js_of_ocaml-tyxml
	wasm_of_ocaml-compiler"

inherit dune git-r3

DESCRIPTION="Compiler from OCaml bytecode to JavaScript"
HOMEPAGE="https://github.com/ocsigen/js_of_ocaml"
EGIT_REPO_URI="https://github.com/ocsigen/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="app-arch/zstd:0=
	dev-ml/cmdliner:0=[ocamlopt?]
	>=dev-ml/dune-3.19:=
	dev-ml/graphics[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/lwt_log:0=[ocamlopt?]
	dev-ml/menhir:0=[ocamlopt?]
	dev-ml/ppx_expect:0=[ocamlopt?]
	dev-ml/ppxlib:0=[ocamlopt?]
	dev-ml/re:0=[ocamlopt?]
	dev-ml/react:0=
	dev-ml/reactiveData:0=[ocamlopt?]
	dev-ml/sedlex:0=[ocamlopt?]
	dev-ml/tyxml[ocamlopt?]
	dev-ml/yojson:0=[ocamlopt?]"
BDEPEND="dev-ml/findlib
	dev-util/binaryen
	test? ( dev-ml/num
		dev-ml/qcheck
		net-libs/nodejs )"

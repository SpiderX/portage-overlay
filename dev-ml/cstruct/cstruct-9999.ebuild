# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# cstruct-async fails
DUNE_PKG_NAME="cstruct cstruct-lwt cstruct-sexp cstruct-unix ppx_cstruct"

inherit dune git-r3

DESCRIPTION="Access C-like structures directly from OCaml"
HOMEPAGE="https://github.com/mirage/ocaml-cstruct"
EGIT_REPO_URI="https://gitlab.com/mirage/ocaml-cstruct.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="test" # ocaml-migrate-parsetree doesn't support fresh OCaml

RDEPEND="dev-ml/fmt:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/ppxlib:0=[ocamlopt?]
	dev-ml/sexplib:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/cppo
		dev-ml/crowbar
		dev-ml/cstruct
		dev-ml/ocaml-migrate-parsetree
		dev-ml/ppx_sexp_conv
		dev-ml/ppxlib
		dev-ml/sexplib )"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}

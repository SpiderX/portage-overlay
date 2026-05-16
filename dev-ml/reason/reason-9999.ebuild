# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="reason rtop"

inherit dune git-r3

DESCRIPTION="Simple, fast & type safe language that leverages JavaScript and OCaml"
HOMEPAGE="https://github.com/reasonml/reason"
EGIT_REPO_URI="https://github.com/reasonml/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/cppo:0=[ocamlopt?]
	dev-ml/dune-build-info:0=[ocamlopt?]
	dev-ml/fix:0=[ocamlopt?]
	dev-ml/menhir:0=[ocamlopt?]
	dev-ml/merlin-extend:0=[ocamlopt?]
	dev-ml/ppx_derivers:0=[ocamlopt?]
	dev-ml/ppxlib:0=[ocamlopt?]
	dev-ml/utop:0=[ocamlopt?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-ml/findlib"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}

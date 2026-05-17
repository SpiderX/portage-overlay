# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="OCaml code generator and runtime library for tree-sitter"
HOMEPAGE="https://github.com/semgrep/ocaml-tree-sitter-core"
EGIT_REPO_URI="https://github.com/semgrep/ocaml-tree-sitter-core.git"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/ANSITerminal:0=[ocamlopt?]
	dev-ml/alcotest:0=[ocamlopt?]
	dev-ml/atd:0=[ocamlopt?]
	dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/ppx_deriving:0=[ocamlopt?]
	dev-ml/sexplib:0=[ocamlopt?]
	dev-ml/tsort:0=[ocamlopt?]"
BDEPEND="dev-ml/dune-configurator
	virtual/pkgconfig"

src_configure() { :; }

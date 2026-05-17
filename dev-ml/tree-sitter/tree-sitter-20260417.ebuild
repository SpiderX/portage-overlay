# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

COMMIT="c4baff8d83b2e1f83f247acb11d0c9dafa5e48f7"
MY_PN="ocaml-${PN}-core"

DESCRIPTION="OCaml code generator and runtime library for tree-sitter"
HOMEPAGE="https://github.com/semgrep/ocaml-tree-sitter-core"
SRC_URI="https://github.com/semgrep/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64"
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

# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PK_NAME="jsonrpc"

inherit dune git-r3

DESCRIPTION="Jsonrpc protocol implementation"
HOMEPAGE="https://github.com/ocaml/ocaml-lsp"
EGIT_REPO_URI="https://github.com/ocaml/ocaml-lsp.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="test" # tests in lsp package

RDEPEND="dev-ml/yojson:0=[ocamlopt?]"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}

# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PK_NAME="jsonrpc"

inherit dune

MY_PN="ocaml-lsp"

DESCRIPTION="Jsonrpc protocol implementation"
HOMEPAGE="https://github.com/ocaml/ocaml-lsp"
SRC_URI="https://github.com/ocaml/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="test" # tests in lsp package

RDEPEND="dev-ml/yojson:0=[ocamlopt?]"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}

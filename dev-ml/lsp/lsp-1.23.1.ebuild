# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PK_NAME="lsp ocaml-lsp-server jsonrpc"

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="OCaml Language Server Protocol implementation"
HOMEPAGE="https://github.com/ocaml/ocaml-lsp"
SRC_URI="https://github.com/ocaml/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-lang/ocaml-5.3.0:0=[ocamlopt?]
	dev-ml/astring:0=
	dev-ml/base:0=[ocamlopt?]
	dev-ml/camlp-streams:=[ocamlopt?]
	dev-ml/chrome-trace:0=[ocamlopt?]
	dev-ml/csexp:0=[ocamlopt?]
	dev-ml/dune-build-info:0=[ocamlopt?]
	dev-ml/dune-private-libs:0=[ocamlopt?]
	dev-ml/dune-rpc:0=[ocamlopt?]
	dev-ml/fiber:0=[ocamlopt?]
	dev-ml/jsonrpc:0=[ocamlopt?]
	>=dev-ml/merlin-5.6-r1:0=[ocamlopt?]
	dev-ml/ocamlc-loc:0=[ocamlopt?]
	dev-ml/ocamlformat:0=[ocamlopt?]
	dev-ml/pp:=[ocamlopt?]
	dev-ml/ppx_yojson_conv_lib:0=[ocamlopt?]
	dev-ml/re:0=[ocamlopt?]
	dev-ml/spawn:0=[ocamlopt?]
	dev-ml/uutf:0=[ocamlopt?]
	dev-ml/xdg:0=[ocamlopt?]
	dev-ml/yojson:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/cinaps
		dev-ml/ppx_expect
		sys-apps/yarn )"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}

src_test() {
	dune-test ${DUNE_PKG_NAME}
}

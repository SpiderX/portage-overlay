# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# vchan-unix needs ocaml-gnt, which can't OCaml 5
DUNE_PKG_NAME="vchan vchan-xen"

inherit dune

DESCRIPTION="Xen Vchan implementation"
HOMEPAGE="https://github.com/mirage/ocaml-vchan"
SRC_URI="https://github.com/mirage/ocaml-${PN}/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/io-page:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/mirage-flow:0=[ocamlopt?]
	dev-ml/mirage-xen:0=[ocamlopt?]
	dev-ml/xenstore:0=[ocamlopt?]
	dev-ml/xenstore-clients:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/ounit2 )"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}

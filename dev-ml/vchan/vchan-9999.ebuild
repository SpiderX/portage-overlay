# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# vchan-unix needs ocaml-gnt, which can't OCaml 5
DUNE_PKG_NAME="vchan vchan-xen"

inherit dune git-r3

DESCRIPTION="Xen Vchan implementation"
HOMEPAGE="https://github.com/mirage/ocaml-vchan"
EGIT_REPO_URI="https://github.com/mirage/ocaml-vchan.git"

LICENSE="ISC"
SLOT="0/${PV}"
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

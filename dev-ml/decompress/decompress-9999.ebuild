# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="decompress rfc1951"

inherit dune git-r3

DESCRIPTION="Implementation of Zlib and GZip in OCaml"
HOMEPAGE="https://github.com/mirage/decompress"
EGIT_REPO_URI="https://github.com/mirage/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/checkseum:0=[ocamlopt?]
	dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/optint:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/astring
		dev-ml/bigstringaf
		dev-ml/bos
		dev-ml/camlzip:1
		dev-ml/crowbar
		dev-ml/fmt
		dev-ml/ocaml-base64
		dev-ml/ocaml-ctypes
		dev-ml/rresult )"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}

src_test() {
	dune-test ${DUNE_PKG_NAME}
}

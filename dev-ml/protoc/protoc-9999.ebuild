# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="ocaml-protoc pbrt pbrt_services pbrt_yojson"

inherit dune git-r3

DESCRIPTION="A Protobuf Compiler for OCaml"
HOMEPAGE="https://github.com/mransan/ocaml-protoc"
EGIT_REPO_URI="https://github.com/mransan/ocaml-protoc.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/ocaml-base64:0=[ocamlopt?]
	dev-ml/stdlib-shims:=[ocamlopt?]
	dev-ml/yojson:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/ppx_deriving )"

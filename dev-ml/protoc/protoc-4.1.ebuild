# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="ocaml-protoc pbrt pbrt_services pbrt_yojson"

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="A Protobuf Compiler for OCaml"
HOMEPAGE="https://github.com/mransan/ocaml-protoc"
SRC_URI="https://github.com/mransan/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/ocaml-base64:0=[ocamlopt?]
	dev-ml/stdlib-shims:=[ocamlopt?]
	dev-ml/yojson:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/ppx_deriving )"

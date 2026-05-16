# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="tar tar-eio tar-mirage tar-unix"

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="Pure OCaml library to read and write tar files"
HOMEPAGE="https://github.com/mirage/ocaml-tar"
SRC_URI="https://github.com/mirage/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-lang/ocaml-5:0=[ocamlopt?]
	dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/decompress:0=[ocamlopt?]
	dev-ml/eio:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/mirage-block:0=[ocamlopt?]
	dev-ml/mirage-kv:0=[ocamlopt?]
	dev-ml/mirage-ptime:0=[ocamlopt?]
	dev-ml/optint:0=[ocamlopt?]
	dev-ml/ptime:0="
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/alcotest-lwt
		dev-ml/mirage-block-unix )"

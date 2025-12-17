# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="ezjsonm ezjsonm-lwt"

inherit dune git-r3

DESCRIPTION="An easy interface on top of the Jsonm library"
HOMEPAGE="https://github.com/mirage/ezjsonm"
EGIT_REPO_URI="https://github.com/mirage/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/hex:0=[ocamlopt?]
	dev-ml/jsonm:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/ppx_sexp_conv:0=[ocamlopt?]
	dev-ml/sexplib:0=[ocamlopt?]
	dev-ml/sexplib0:0=[ocamlopt?]
	dev-ml/uutf"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/js_of_ocaml
		net-libs/nodejs )"

# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="h2 h2-async h2-eio h2-lwt h2-lwt-unix h2-mirage hpack"

inherit dune git-r3

DESCRIPTION="An HTTP/2 implementation written in pure OCaml"
HOMEPAGE="https://github.com/anmonteiro/ocaml-h2"
EGIT_REPO_URI="https://github.com/anmonteiro/ocaml-h2.git"

LICENSE="BSD"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/angstrom:0=[ocamlopt?]
	dev-ml/bigstringaf:0=[ocamlopt?]
	dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/faraday:0=[ocamlopt?]
	dev-ml/gluten:0=[ocamlopt?]
	dev-ml/httpun:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/mirage-flow:0=[ocamlopt?]
	dev-ml/ocaml-base64:0=[ocamlopt?]
	dev-ml/psq:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/hex
		dev-ml/yojson )"

# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="carton carton-git carton-lwt"

inherit dune

DESCRIPTION="Implementation of PACKv2 file in OCaml"
HOMEPAGE="https://github.com/robur-coop/carton"
SRC_URI="https://github.com/robur-coop/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/astring:0=
	dev-ml/base:0=[ocamlopt?]
	dev-ml/bigstringaf:0=[ocamlopt?]
	dev-ml/bos:0=
	dev-ml/checkseum:0=[ocamlopt?]
	dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/decompress:0=[ocamlopt?]
	dev-ml/digestif:0=[ocamlopt?]
	dev-ml/duff:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/fpath:0=
	dev-ml/hxd:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/ke:0=[ocamlopt?]
	dev-ml/optint:0=[ocamlopt?]
	dev-ml/psq:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/alcotest-lwt
		dev-ml/crowbar
		dev-ml/mirage-flow
		dev-ml/ocaml-base64
		dev-ml/rresult )"

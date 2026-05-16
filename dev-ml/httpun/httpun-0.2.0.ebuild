# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="httpun httpun-async httpun-eio httpun-lwt httpun-lwt-unix
	httpun-mirage httpun-types"

inherit dune

DESCRIPTION="A scalable web server written in OCaml"
HOMEPAGE="https://github.com/anmonteiro/httpun"
SRC_URI="https://github.com/anmonteiro/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/angstrom:0=[ocamlopt?]
	dev-ml/async:0=[ocamlopt?]
	dev-ml/bigstringaf:0=[ocamlopt?]
	dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/faraday:0=[ocamlopt?]
	dev-ml/gluten:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/mirage-flow:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"

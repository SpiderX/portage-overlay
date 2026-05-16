# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="gluten gluten-async gluten-eio gluten-lwt gluten-lwt-unix
	gluten-mirage"

inherit dune

DESCRIPTION="Reusable runtime library for network protocols"
HOMEPAGE="https://github.com/anmonteiro/gluten"
SRC_URI="https://github.com/anmonteiro/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/async:0=[ocamlopt?]
	dev-ml/bigstringaf:0=[ocamlopt?]
	dev-ml/conduit:0=[ocamlopt?]
	dev-ml/core:0=[ocamlopt?]
	dev-ml/eio:0=[ocamlopt?]
	dev-ml/faraday:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/lwt_ssl:0=[ocamlopt?]
	dev-ml/mirage-flow:0=[ocamlopt?]
	dev-ml/tls:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"

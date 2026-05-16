# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="h1 h1-lwt-unix"

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="A scalable web server for OCaml"
HOMEPAGE="https://github.com/robur-coop/ocaml-h1"
SRC_URI="https://github.com/robur-coop/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/angstrom:0=[ocamlopt?]
	dev-ml/bstr:0=[ocamlopt?]
	dev-ml/faraday:0=[ocamlopt?]
	dev-ml/httpun:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/ocaml-base64:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/stdio )"

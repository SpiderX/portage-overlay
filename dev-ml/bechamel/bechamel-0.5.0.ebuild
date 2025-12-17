# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="bechamel bechamel-js bechamel-notty bechamel-perf mperf"

inherit dune

DESCRIPTION="Agnostic benchmark in OCaml"
HOMEPAGE="https://github.com/mirage/bechamel"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/data-encoding:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/jsonm:0=[ocamlopt?]
	dev-ml/notty:0=[ocamlopt?]
	dev-ml/rresult:0="
BDEPEND="test? ( dev-ml/alcotest )"

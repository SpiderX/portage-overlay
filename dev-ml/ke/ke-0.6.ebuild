# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Fast implementation of queue in OCaml"
HOMEPAGE="https://github.com/mirage/ke"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/fmt:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/bechamel
		dev-ml/bigstringaf
		dev-ml/cmdliner
		dev-ml/core_bench
		dev-ml/crowbar
		dev-ml/jsonm
		dev-ml/lwt
		dev-ml/ocplib-json-typed
		dev-ml/psq
		dev-ml/rresult )"

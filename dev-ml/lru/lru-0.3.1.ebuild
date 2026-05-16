# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Scalable LRU caches for OCaml"
HOMEPAGE="https://github.com/pqwy/lru"
SRC_URI="https://github.com/pqwy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/psq:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/qcheck )"

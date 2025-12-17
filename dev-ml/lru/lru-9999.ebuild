# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Scalable LRU caches for OCaml"
HOMEPAGE="https://github.com/pqwy/lru"
EGIT_REPO_URI="https://github.com/pqwy/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="test" # fails

RDEPEND="dev-ml/psq:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/qcheck )"

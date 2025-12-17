# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="A scheduler independent timeout mechanism"
HOMEPAGE="https://github.com/ocaml-multicore/domain-local-timeout"
EGIT_REPO_URI="https://github.com/ocaml-multicore/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/thread-table:0=[ocamlopt?]
	>=dev-ml/mtime-2.0.0:0=
	dev-ml/psq:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/domain-local-await
		dev-ml/mdx )"

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Scheduler independent blocking"
HOMEPAGE="https://github.com/ocaml-multicore/domain-local-await"
EGIT_REPO_URI="https://github.com/ocaml-multicore/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/thread-table[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/domain_shims
		dev-ml/mdx
		dev-ml/ocaml-version )"

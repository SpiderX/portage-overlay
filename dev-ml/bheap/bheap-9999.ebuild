# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="OCaml binary heap implementation"
HOMEPAGE="https://github.com/backtracking/bheap"
EGIT_REPO_URI="https://github.com/backtracking/${PN}.git"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-ml/stdlib-shims )"

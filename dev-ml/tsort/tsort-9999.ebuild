# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Easy to use and user-friendly topological sort module for OCaml"
HOMEPAGE="https://github.com/dmbaturin/ocaml-tsort"
EGIT_REPO_URI="https://github.com/dmbaturin/ocaml-tsort.git"

LICENSE="BSD"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-ml/alcotest )"

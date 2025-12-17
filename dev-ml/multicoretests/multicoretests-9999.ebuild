# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="multicoretests qcheck-stm qcheck-lin qcheck-multicoretests-util"

inherit dune git-r3

DESCRIPTION="Various utility functions for property-based testing"
HOMEPAGE="https://github.com/ocaml-multicore/multicoretests"
EGIT_REPO_URI="https://github.com/ocaml-multicore/${PN}.git"

LICENSE="BSD-2"
SLOT="0/${PV}"
IUSE="+ocamlopt"
RESTRICT="test" #fails

RDEPEND="dev-ml/qcheck:0=[ocamlopt?]"

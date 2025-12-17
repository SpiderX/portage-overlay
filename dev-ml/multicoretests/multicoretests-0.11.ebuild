# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="multicoretests qcheck-stm qcheck-lin qcheck-multicoretests-util"

inherit dune

DESCRIPTION="Various utility functions for property-based testing"
HOMEPAGE="https://github.com/ocaml-multicore/multicoretests"
SRC_URI="https://github.com/ocaml-multicore/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"
RESTRICT="test" #fails

RDEPEND="dev-ml/qcheck:0=[ocamlopt?]"

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="Easy to use and user-friendly topological sort module for OCaml"
HOMEPAGE="https://github.com/dmbaturin/ocaml-tsort"
SRC_URI="https://github.com/dmbaturin/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-ml/alcotest )"

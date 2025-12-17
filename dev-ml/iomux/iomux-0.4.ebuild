# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="OCaml bindings for IO multiplexers"
HOMEPAGE="https://github.com/ocaml-multicore/ocaml-iomux"
SRC_URI="https://github.com/ocaml-multicore/ocaml-${PN}/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

BDEPEND=">=dev-ml/dune-configurator-3.19
	test? ( dev-ml/alcotest )"

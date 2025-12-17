# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="multicore-magic multicore-magic-dscheck"

inherit dune

DESCRIPTION="Low-level multicore utilities for OCaml"
HOMEPAGE="https://github.com/ocaml-multicore/multicore-magic"
SRC_URI="https://github.com/ocaml-multicore/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/dscheck:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/domain_shims
		dev-ml/js_of_ocaml
		net-libs/nodejs )"

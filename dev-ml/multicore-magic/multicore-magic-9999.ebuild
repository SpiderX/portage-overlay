# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="multicore-magic multicore-magic-dscheck"

inherit dune git-r3

DESCRIPTION="Low-level multicore utilities for OCaml"
HOMEPAGE="https://github.com/ocaml-multicore/multicore-magic"
EGIT_REPO_URI="https://github.com/ocaml-multicore/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/dscheck:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/domain_shims
		dev-ml/js_of_ocaml
		net-libs/nodejs )"

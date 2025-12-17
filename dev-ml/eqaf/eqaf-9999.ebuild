# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="eqaf eqaf-cstruct"

inherit dune git-r3

DESCRIPTION="Constant-time equal function on string"
HOMEPAGE="https://github.com/mirage/eqaf"
EGIT_REPO_URI="https://github.com/mirage/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/cstruct:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/bechamel
		dev-ml/crowbar
		dev-ml/fmt
		dev-ml/ocaml-base64 )"

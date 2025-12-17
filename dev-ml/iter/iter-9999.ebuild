# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Simple iterator abstract datatype"
HOMEPAGE="https://github.com/c-cube/iter"
EGIT_REPO_URI="https://github.com/c-cube/${PN}.git"

LICENSE="BSD-2"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-ml/qcheck
		dev-ml/mdx
		dev-ml/ounit2 )"

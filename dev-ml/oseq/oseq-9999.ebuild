# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Purely functional iterators compatible with standard seq"
HOMEPAGE="https://github.com/c-cube/oseq"
EGIT_REPO_URI="https://github.com/c-cube/${PN}.git"

LICENSE="BSD"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-ml/containers
		dev-ml/gen
		dev-ml/qcheck )"

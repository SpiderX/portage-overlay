# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/audreyfeldroy/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python package to guess whether a file is binary or text"
HOMEPAGE="https://github.com/audreyfeldroy/binaryornot"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/chardet[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/hypothesis[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}"/${P}-tests.patch )

distutils_enable_tests unittest

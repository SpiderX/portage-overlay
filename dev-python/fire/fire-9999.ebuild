# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,10} )
EGIT_REPO_URI="https://github.com/google/python-fire.git"

inherit distutils-r1 git-r3

DESCRIPTION="Library for automatically generating CLI from object"
HOMEPAGE="https://github.com/google/python-fire"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/six[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/python-levenshtein[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

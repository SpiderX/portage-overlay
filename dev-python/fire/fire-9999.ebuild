# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Library for automatically generating CLI from object"
HOMEPAGE="https://github.com/google/python-fire"
EGIT_REPO_URI="https://github.com/google/python-fire.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/termcolor[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/levenshtein[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

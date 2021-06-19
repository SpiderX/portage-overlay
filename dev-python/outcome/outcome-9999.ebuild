# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/python-trio/${MY_PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Capture the outcome of Python function calls"
HOMEPAGE="https://github.com/python-trio/outcome"
SRC_URI=""

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS=""

RDEPEND=">=dev-python/attrs-19.2.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/async_generator[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

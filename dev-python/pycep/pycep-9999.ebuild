# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/gruebel/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A Python based Bicep parser"
HOMEPAGE="https://github.com/gruebel/pycep"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND=">=dev-python/lark-1.1.2[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/assertpy[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

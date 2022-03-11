# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/ionelmc/python-pygaljs.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python package providing assets from js module for pygal"
HOMEPAGE="https://github.com/ionelmc/python-pygaljs"
SRC_URI=""

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/aspectlib[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

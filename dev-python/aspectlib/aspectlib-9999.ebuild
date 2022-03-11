# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/ionelmc/python-aspectlib.git"

inherit distutils-r1 git-r3

DESCRIPTION="Aspect-oriented programming, monkey-patch and decorators library"
HOMEPAGE="https://github.com/ionelmc/python-aspectlib"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/fields[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/process-tests[${PYTHON_USEDEP}]
		www-servers/tornado[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

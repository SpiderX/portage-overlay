# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Helper functions for pytest"
HOMEPAGE="https://github.com/python-coincidence/coincidence"
SRC_URI="https://github.com/python-coincidence/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/domdf-python-tools[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/pytest-regressions[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="dev-python/whey[${PYTHON_USEDEP}]
	test? ( dev-python/toml[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

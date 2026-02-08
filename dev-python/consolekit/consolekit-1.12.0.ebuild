# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Additional utilities for click"
HOMEPAGE="https://github.com/domdfcoding/consolekit"
SRC_URI="https://github.com/domdfcoding/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/deprecation-alias[${PYTHON_USEDEP}]
	dev-python/domdf-python-tools[${PYTHON_USEDEP}]
	dev-python/mistletoe[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/coincidence[${PYTHON_USEDEP}]
		dev-python/colorama[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-{datadir,regressions} )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError: FILES DIFFER
	tests/test_options.py::test_prompt_option
)

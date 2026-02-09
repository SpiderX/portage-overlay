# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Call stack profiler for Python"
HOMEPAGE="https://github.com/joerick/pyinstrument"
EGIT_REPO_URI="https://github.com/joerick/${PN}.git"

LICENSE="BSD"
SLOT="0"
RESTRICT="test" # circular import

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/greenlet[${PYTHON_USEDEP}]
		dev-python/trio[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( flaky pytest-asyncio )
distutils_enable_tests pytest

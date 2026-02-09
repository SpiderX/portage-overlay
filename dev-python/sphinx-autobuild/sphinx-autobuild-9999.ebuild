# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Autorebuild documentation on change"
HOMEPAGE="https://github.com/sphinx-doc/sphinx-autobuild"
EGIT_REPO_URI="https://github.com/sphinx-doc/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/starlette[${PYTHON_USEDEP}]
	dev-python/uvicorn[${PYTHON_USEDEP}]
	dev-python/watchfiles[${PYTHON_USEDEP}]
	dev-python/websockets[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/httpx[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

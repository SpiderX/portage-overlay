# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="PyPI JSON API client library"
HOMEPAGE="https://github.com/repo-helper/pypi-json"
EGIT_REPO_URI="https://github.com/repo-helper/${PN}.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/apeye[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="dev-python/whey[${PYTHON_USEDEP}]
	test? ( dev-python/betamax[${PYTHON_USEDEP}]
		dev-python/coincidence[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Utilities for handling packages"
HOMEPAGE="https://github.com/domdfcoding/shippinglabel"
EGIT_REPO_URI="https://github.com/domdfcoding/${PN}.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/dist-meta[${PYTHON_USEDEP}]
	dev-python/dom-toml[${PYTHON_USEDEP}]
	dev-python/domdf-python-tools[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="dev-python/hatch-requirements-txt[${PYTHON_USEDEP}]
	test? ( dev-python/betamax[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-{datadir,regressions,rerunfailures,timeout} )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	tests/test_requirements.py::test_list_requirements_pytest
)

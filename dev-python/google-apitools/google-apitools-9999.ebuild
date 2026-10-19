# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 git-r3

DESCRIPTION="Python library to manipulate Google APIs"
HOMEPAGE="https://github.com/google/apitools"
EGIT_REPO_URI="https://github.com/google/apitools.git"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/fasteners[${PYTHON_USEDEP}]
	dev-python/oauth2client[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/python-gflags[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}"-0.5.37-tests.patch )

EPYTEST_PLUGINS=()
EPYTEST_IGNORE=( samples )
distutils_enable_tests pytest

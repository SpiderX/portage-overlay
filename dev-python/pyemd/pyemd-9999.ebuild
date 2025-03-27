# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Fast EMD for Python"
HOMEPAGE="https://github.com/wmayner/pyemd"
EGIT_REPO_URI="https://github.com/wmayner/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

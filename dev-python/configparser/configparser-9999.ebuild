# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
EGIT_REPO_URI="https://github.com/jaraco/${PN}.git"
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Backport of configparser from Python 3"
HOMEPAGE="https://github.com/jaraco/configparser"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/test[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} python3_13t )

inherit distutils-r1 git-r3

DESCRIPTION="Fixtures for pytest to retrieve test resources from filesystem"
HOMEPAGE="https://github.com/Tblue/pytest-datadir-ng"
EGIT_REPO_URI="https://github.com/Tblue/${PN}.git"

LICENSE="BSD"
SLOT=0
RESTRICT="test" # no test

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

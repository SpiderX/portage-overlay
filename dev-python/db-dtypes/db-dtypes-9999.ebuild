# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 git-r3

DESCRIPTION="Pandas Data Types for SQL systems"
HOMEPAGE="https://github.com/googleapis/python-db-dtypes-pandas"
EGIT_REPO_URI="https://github.com/googleapis/python-db-dtypes-pandas.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/pyarrow[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

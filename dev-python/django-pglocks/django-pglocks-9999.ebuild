# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="PostgreSQL locking context managers and functions for Django"
HOMEPAGE="https://github.com/Xof/django-pglocks"
EGIT_REPO_URI="https://github.com/Xof/${PN}.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # needs posgtresql

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Independent BSON codec for Python"
HOMEPAGE="https://github.com/py-bson/bson"
EGIT_REPO_URI="https://github.com/py-bson/${PN}.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Independent BSON codec for Python"
HOMEPAGE="https://github.com/py-bson/bson"
SRC_URI="https://github.com/py-bson/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="!dev-python/pymongo[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${PN}"-0.5.10-tests.patch )

distutils_enable_tests pytest

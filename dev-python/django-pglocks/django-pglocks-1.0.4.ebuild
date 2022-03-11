# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="PostgreSQL locking context managers and functions for Django"
HOMEPAGE="https://github.com/Xof/django-pglocks"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # needs posgtresql

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

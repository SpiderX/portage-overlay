# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="A dict-like object supports recursive merge operation"
HOMEPAGE="https://github.com/ssato/python-m9dicts https://pypi.python.org/pypi/m9dicts"
SRC_URI="https://github.com/ssato/python-${PN}/archive/RELEASE_${PV}.tar.gz -> ${P}.tar.gz mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

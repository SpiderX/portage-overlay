# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="AutoRest swagger generator Python client runtime"
HOMEPAGE="https://pypi.python.org/pypi/msrest/ https://github.com/Azure/msrest-for-python"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/certifi[${PYTHON_USEDEP}]
	>=dev-python/isodate-0.5.4[${PYTHON_USEDEP}]
	>=dev-python/requests-0.5[${PYTHON_USEDEP}]
	dev-python/requests-oauthlib[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/enum34[${PYTHON_USEDEP}]' python2_7)"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

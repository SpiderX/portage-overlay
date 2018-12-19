# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
MY_PN="python-email-validator"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1

DESCRIPTION="An email syntax and deliverability validation library"
HOMEPAGE="https://github.com/JoshData/python-email-validator"
SRC_URI="https://github.com/JoshData/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/idna[${PYTHON_USEDEP}]
	virtual/python-dnspython[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

python_test() {
	"${PYTHON}" email_validator/__init__.py --tests < test_pass.txt \
		|| die "tests failed with ${EPYTHON}"
}

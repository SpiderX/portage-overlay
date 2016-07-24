# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Implementation of per object permissions for Django 1.2+"
HOMEPAGE="https://github.com/lukaszb/django-guardian"
SRC_URI="https://github.com/lukaszb/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="test"

CDEPEND=">=dev-python/django-1.2[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]"

RDEPEND="${CDEPEND}"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( ${CDEPEND} )"

python_test() {
	esetup.py test || die
}
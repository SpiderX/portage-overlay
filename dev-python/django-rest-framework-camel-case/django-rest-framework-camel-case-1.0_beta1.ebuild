# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

MY_PN="djangorestframework-camel-case"
MY_PV="${PV//_beta/b}"
MY_P="${MY_PN}-${MY_PV}"

inherit distutils-r1

DESCRIPTION="Camel case JSON support for Django REST framework"
HOMEPAGE="https://github.com/vbabiy/djangorestframework-camel-case"
SRC_URI="https://github.com/vbabiy/${MY_PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/django-rest-framework[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

python_test() {
	emake test
}

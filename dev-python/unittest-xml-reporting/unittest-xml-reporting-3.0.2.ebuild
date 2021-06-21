# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 optfeature

DESCRIPTION="unittest-based test runner with Ant/JUnit like XML reporting"
HOMEPAGE="https://github.com/xmlrunner/unittest-xml-reporting"
SRC_URI="https://github.com/xmlrunner/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/lxml[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/django[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

pkg_postinst() {
	optfeature "integration with django" dev-python/django
}

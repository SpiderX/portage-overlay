# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1 eutils

DESCRIPTION="unittest-based test runner with Ant/JUnit like XML reporting"
HOMEPAGE="https://github.com/xmlrunner/unittest-xml-reporting"
SRC_URI="https://github.com/xmlrunner/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # network-sandbox

RDEPEND="dev-python/lxml[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/django[${PYTHON_USEDEP}] )"

python_test() {
	"${PYTHON}" -m unittest discover -v test || die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "integration with django" dev-python/django
}

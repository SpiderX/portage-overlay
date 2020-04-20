# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/xmlrunner/${PN}.git"

inherit distutils-r1 eutils git-r3

DESCRIPTION="unittest-based test runner with Ant/JUnit like XML reporting"
HOMEPAGE="https://github.com/xmlrunner/unittest-xml-reporting"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
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

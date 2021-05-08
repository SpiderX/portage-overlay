# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1 optfeature

DESCRIPTION="Option groups missing in Click"
HOMEPAGE="https://www.crummy.com/software/BeautifulSoup"
SRC_URI="https://www.crummy.com/software/BeautifulSoup/bs4/download/4.9/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/soupsieve[${PYTHON_USEDEP}]"

distutils_enable_tests unittest

python_prepare_all() {
	# Don't run tests
	sed -i '$d' convert-py3k || die "sed failed"
	./convert-py3k || die "convert-py3k failed"
	distutils-r1_python_prepare_all
}

python_test() {
	pushd py3k || die "pushd failed"
	"${PYTHON}" -m unittest_or_fail discover -v || die "tests failed with ${EPYTHON}"
	popd || die "popd failed"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}

pkg_postinst() {
	optfeature "integration with xml parser" dev-python/lxml
	optfeature "integration with html parser" dev-python/html5lib
}

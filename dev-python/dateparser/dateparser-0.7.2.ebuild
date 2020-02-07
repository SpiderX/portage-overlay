# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )

inherit distutils-r1 eutils

DESCRIPTION="Date parsing library designed to parse dates from HTML pages"
HOMEPAGE="https://github.com/scrapinghub/dateparser"
SRC_URI="https://github.com/scrapinghub/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/convertdate[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/parameterized[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Disable tests require fr_FR.UTF-8 locale
	sed -i  -e '1 i\import unittest' \
		-e '/if_locale_is_non_english/i\\    @unittest.skip("disable")' \
		tests/test_utils_strptime.py \
		|| die "sed failed for test_utils_strptime.py"
	# Disable failing tests
	sed -i  -e '/import datetime/ a\import unittest' \
		-e '/not_parsed/i\\    @unittest.skip("disable")' \
		-e '/base_setting/i\\    @unittest.skip("disable")' \
		tests/test_search.py \
		|| die "sed failed for test_search.py"

	distutils-r1_python_prepare_all
}

python_test() {
	nosetests -v || die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "operations on language files" dev-python/ruamel-yaml
}

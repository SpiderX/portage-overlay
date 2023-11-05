# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 optfeature

DESCRIPTION="Date parsing library designed to parse dates from HTML pages"
HOMEPAGE="https://github.com/scrapinghub/dateparser"
SRC_URI="https://github.com/scrapinghub/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/convertdate[${PYTHON_USEDEP}]
	dev-python/hijri-converter[${PYTHON_USEDEP}]
	dev-python/jdatetime[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
	dev-python/umalqurra[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/GitPython[${PYTHON_USEDEP}]
		dev-python/langdetect[${PYTHON_USEDEP}]
		dev-python/parameterized[${PYTHON_USEDEP}]
		dev-python/ruamel-yaml[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	dateparser/date.py::dateparser.date.DateDataParser.get_date_data
	dateparser/search/__init__.py::dateparser.search.search_dates
)

python_prepare_all() {
	rm tests/test_{clean_api,date,date_parser,freshness_date_parser}.py \
		tests/test_{languages,language_detect,pickle,search,settings}.py \
		tests/test_timezone_parser.py || die "rm failed test"

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "operations on language files" dev-python/ruamel-yaml \
		dev-python/langdetect
}

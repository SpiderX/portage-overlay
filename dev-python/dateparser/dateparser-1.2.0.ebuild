# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 optfeature

DESCRIPTION="Date parsing library designed to parse dates from HTML pages"
HOMEPAGE="https://github.com/scrapinghub/dateparser"
SRC_URI="https://github.com/scrapinghub/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/convertdate[${PYTHON_USEDEP}]
	dev-python/hijri-converter[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-libs/fastText[python,${PYTHON_USEDEP}]
		dev-python/gitpython[${PYTHON_USEDEP}]
		dev-python/langdetect[${PYTHON_USEDEP}]
		dev-python/parameterized[${PYTHON_USEDEP}]
		dev-python/parsel[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/ruamel-yaml[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	dateparser/date.py::dateparser.date.DateDataParser.get_date_data
	dateparser/search/__init__.py::dateparser.search.search_dates
	tests/test_search.py::TestTranslateSearch::test_relative_base_setting_1_en
	tests/test_search.py::TestTranslateSearch::test_splitting_of_not_parsed_1_en
	tests/test_search.py::TestTranslateSearch::test_splitting_of_not_parsed_5_en
	tests/test_search.py::TestTranslateSearch::test_splitting_of_not_parsed_6_sv
	tests/test_timezone_parser.py::TestLocalTZOffset::test_timezone_offset_calculation_0
	tests/test_timezone_parser.py::TestLocalTZOffset::test_timezone_offset_calculation_1
	tests/test_timezone_parser.py::TestLocalTZOffset::test_timezone_offset_calculation_2
	tests/test_timezone_parser.py::TestLocalTZOffset::test_timezone_offset_calculation_3
	tests/test_timezone_parser.py::TestLocalTZOffset::test_timezone_offset_calculation_4
	tests/test_language_detect.py::CustomLangDetectParserTest::test_custom_language_detect_fast_text_0
	tests/test_language_detect.py::CustomLangDetectParserTest::test_custom_language_detect_fast_text_1
)

python_prepare_all() {
	rm -rf fuzzing || die "rm failed for fuzzing"
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "operations on language files" dev-python/ruamel-yaml \
		dev-python/langdetect
}

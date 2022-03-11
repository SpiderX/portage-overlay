# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 optfeature

DESCRIPTION="py.test fixture for benchmarking code"
HOMEPAGE="https://github.com/ionelmc/pytest-benchmark"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/py-cpuinfo[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/aspectlib[${PYTHON_USEDEP}]
		dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/elasticsearch-py[${PYTHON_USEDEP}]
		dev-python/pygal[${PYTHON_USEDEP}]
		dev-python/pygaljs[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Failed: fnmatch and Failed: nomatch
	tests/test_benchmark.py::test_groups
	tests/test_benchmark.py::test_group_by_func
	tests/test_benchmark.py::test_group_by_fullfunc
	tests/test_benchmark.py::test_group_by_param_all
	tests/test_benchmark.py::test_group_by_param_select
	tests/test_benchmark.py::test_group_by_param_select_multiple
	tests/test_benchmark.py::test_group_by_fullname
	tests/test_benchmark.py::test_only_override_skip
	tests/test_benchmark.py::test_fixtures_also_skipped
	tests/test_benchmark.py::test_max_time_min_rounds
	tests/test_benchmark.py::test_max_time
	tests/test_benchmark.py::test_disable_gc
	tests/test_benchmark.py::test_custom_timer
	tests/test_benchmark.py::test_sort_by_mean
	tests/test_benchmark.py::test_basic
	tests/test_benchmark.py::test_skip
	tests/test_benchmark.py::test_disable
	tests/test_benchmark.py::test_mark_selection
	tests/test_benchmark.py::test_only_benchmarks
	tests/test_cli.py::test_help
	# re.error: bad character range
	tests/test_cli.py::test_help_compare
	tests/test_cli.py::test_help_compare
)

pkg_postinst() {
	optfeature "integration with Elasticsearch" dev-python/elasticsearch-py
	optfeature "support of histogram" dev-python/pygal dev-python/pygaljs
	optfeature "support of aspect" dev-python/aspectlib
}

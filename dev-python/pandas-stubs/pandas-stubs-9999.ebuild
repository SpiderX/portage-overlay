# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
EGIT_REPO_URI="https://github.com/pandas-dev/${PN}.git"
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Type annotations for pandas"
HOMEPAGE="https://github.com/pandas-dev/pandas-stubs"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/html5lib[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/odfpy[${PYTHON_USEDEP}]
		dev-python/openpyxl[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pyarrow[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
		dev-python/tables[${PYTHON_USEDEP}]
		dev-python/tabulate[${PYTHON_USEDEP}]
		dev-python/xarray[${PYTHON_USEDEP}]
		dev-python/xlsxwriter[${PYTHON_USEDEP}] )"

#EPYTEST_XDIST=1
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	tests/test_frame.py::test_types_to_feather # Support for codec 'zstd' not built
	tests/test_io.py::test_orc # ImportError: 'pyarrow.orc'
	tests/test_io.py::test_orc_path # ImportError: 'pyarrow.orc'
	tests/test_io.py::test_orc_buffer # ImportError: 'pyarrow.orc'
	tests/test_io.py::test_orc_columns # ImportError: 'pyarrow.orc'
	tests/test_io.py::test_orc_bytes # ImportError: 'pyarrow.orc'
	tests/test_io.py::test_all_read_without_lxml_dtype_backend # ImportError: 'pyarrow.orc'
	tests/test_io.py::test_spss # ImportError: 'pyreadstat'
	tests/test_io.py::test_read_excel # ImportError: 'python-calamine'
	tests/test_series.py::test_types_agg # RuntimeError
	tests/test_series.py::test_types_aggregate # RuntimeError
	tests/test_io.py::test_excel_reader # ImportError: 'python-calamine'
	tests/test_plotting.py::test_plot_keywords # TypeError: Axes.boxplot()
)

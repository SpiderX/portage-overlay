# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="SQL databases in Python"
HOMEPAGE="https://github.com/fastapi/sqlmodel"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/dirty-equals[${PYTHON_USEDEP}]
		dev-python/fastapi[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_IGNORE=( docs_src/tutorial/fastapi/app_testing )

EPYTEST_DESELECT=(
	# No such file or directory: 'coverage'
	tests/test_tutorial/test_create_db_and_table/test_tutorial001.py::test_create_db_and_table
	tests/test_tutorial/test_create_db_and_table/test_tutorial001_py310.py::test_create_db_and_table
	tests/test_tutorial/test_fastapi/test_app_testing/test_tutorial001_py310_tests_main.py::test_run_tests
	tests/test_tutorial/test_fastapi/test_app_testing/test_tutorial001_py39_tests_main.py::test_run_tests
	tests/test_tutorial/test_fastapi/test_app_testing/test_tutorial001_tests_main.py::test_run_tests
)

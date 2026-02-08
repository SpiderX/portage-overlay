# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 pypi

DESCRIPTION="FastAPI framework"
HOMEPAGE="https://github.com/fastapi/fastapi"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/starlette[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/annotated-doc[${PYTHON_USEDEP}]
		dev-python/dirty-equals[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/orjson[${PYTHON_USEDEP}]
		dev-python/python-multipart[${PYTHON_USEDEP}]
		dev-python/sqlmodel[${PYTHON_USEDEP}]
		dev-python/strawberry-graphql[${PYTHON_USEDEP}]
		dev-python/ujson[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	tests/test_fastapi_cli.py::test_fastapi_cli
	# requires 'multipart'
	tests/test_multipart_installation.py::test_incorrect_multipart_installed_form
	tests/test_multipart_installation.py::test_incorrect_multipart_installed_file_upload
	tests/test_multipart_installation.py::test_incorrect_multipart_installed_file_bytes
	tests/test_multipart_installation.py::test_incorrect_multipart_installed_multi_form
	tests/test_multipart_installation.py::test_incorrect_multipart_installed_form_file
	tests/test_multipart_installation.py::test_no_multipart_installed
	tests/test_multipart_installation.py::test_no_multipart_installed_file
	tests/test_multipart_installation.py::test_no_multipart_installed_file_bytes
	tests/test_multipart_installation.py::test_no_multipart_installed_multi_form
	tests/test_multipart_installation.py::test_no_multipart_installed_form_file
	# requires "python-multipart"
	tests/test_multipart_installation.py::test_old_multipart_installed
)

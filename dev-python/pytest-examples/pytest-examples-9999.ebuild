# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 edo git-r3

DESCRIPTION="Pytest plugin for testing examples in docstrings and markdown files"
HOMEPAGE="https://github.com/pydantic/pytest-examples"
EGIT_REPO_URI="https://github.com/pydantic/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/black[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/ruff[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	tests/test_lint.py::test_ruff_offset
	tests/test_run_examples.py::test_run_example_ok_fail
	tests/test_run_examples.py::test_ruff_error
)

python_test() {
	edo ln -s /usr/bin/ruff "${BUILD_DIR}"/install/usr/bin/ruff
	distutils-r1_python_test
	edo rm "${BUILD_DIR}"/install/usr/bin/ruff
}

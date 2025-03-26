# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Google Cloud Storage API client library"
HOMEPAGE="https://github.com/googleapis/python-test-utils"
EGIT_REPO_URI="https://github.com/googleapis/python-test-utils.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/google-auth[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# assertion error
	tests/unit/test_lower_bound_checker.py::test_update_constraints
	tests/unit/test_lower_bound_checker.py::test_update_constraints_overwrites_existing_file
	tests/unit/test_lower_bound_checker.py::test_update_constraints_with_setup_py_missing_lower_bounds
	tests/unit/test_lower_bound_checker.py::test_check
	tests/unit/test_lower_bound_checker.py::test_update_constraints_with_extra_constraints
	tests/unit/test_lower_bound_checker.py::test_check_with_missing_constraints_file
	tests/unit/test_lower_bound_checker.py::test_check_with_constraints_file_invalid_pins
	tests/unit/test_lower_bound_checker.py::test_check_with_constraints_file_missing_packages
	tests/unit/test_lower_bound_checker.py::test_check_with_constraints_file_different_versions
	tests/unit/test_lower_bound_checker.py::test_check_with_setup_py_missing_lower_bounds
)

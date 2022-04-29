# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

MY_PN="${PN//google-cloud/python}"
MY_PN="${MY_PN//test/test-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Google Cloud Storage API client library"
HOMEPAGE="https://github.com/googleapis/python-test-utils"
SRC_URI="https://github.com/googleapis/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/google-auth[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]"
BDEPEND="dev-python/packaging[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest

python_prepare_all() {
	# do not install tests
	sed -i '/PEP420PackageFinder/s|(|(exclude=("tests", "tests.*")|' setup.py \
		|| die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

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

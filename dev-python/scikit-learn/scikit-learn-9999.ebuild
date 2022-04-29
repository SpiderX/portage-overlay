# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/scikit-learn/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Machine learning in Python"
HOMEPAGE="https://github.com/scikit-learn/scikit-learn"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/joblib[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/threadpoolctl[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# ealloc(): invalid next size
	sklearn/decomposition/tests/test_kernel_pca.py::test_kernel_pca_determenistic_output
	sklearn/decomposition/tests/test_kernel_pca.py::test_kernel_pca_consistent_transform
	sklearn/decomposition/tests/test_kernel_pca.py::test_32_64_decomposition_shape
	sklearn/decomposition/tests/test_kernel_pca.py::test_kernel_pca_raise_not_fitted_error
	sklearn/tests/test_common.py::test_estimators
	sklearn/tests/test_common.py::test_check_n_features_in_after_fitting
	sklearn/utils/tests/test_extmath.py::test_randomized_eigsh_reconst_low_rank
	sklearn/utils/tests/test_extmath.py::test_randomized_eigsh_compared_to_others
)

python_compile() {
	distutils-r1_python_compile "$(usex test '-i' '-v')"
}

python_test() {
	epytest -v sklearn || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}

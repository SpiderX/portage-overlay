# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10,11} )
EGIT_REPO_URI="https://github.com/spotify/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Approximate Nearest Neighbors in C++/Python"
HOMEPAGE="https://github.com/spotify/annoy"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="test"
PROPERTIES="test_network"

BDEPEND="dev-python/nose[${PYTHON_USEDEP}]
	test? ( dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}] )"

distutils_enable_tests nose

EPYTEST_DESELECT=(
	# Unable to synchronously open file
	test/accuracy_test.py::test_glove_25
	test/accuracy_test.py::test_nytimes_16
)

python_prepare_all() {
	# Fixture "setUp" called directly
	rm test/on_disk_build_test.py || die "rm failed"

	distutils-r1_python_prepare_all
}

python_compile_all() {
	use test && esetup.py build_ext --inplace
}

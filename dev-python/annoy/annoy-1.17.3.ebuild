# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Approximate Nearest Neighbors in C++/Python"
HOMEPAGE="https://github.com/spotify/annoy"
SRC_URI="https://github.com/spotify/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
PROPERTIES="test_network"

BDEPEND="test? ( dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Unable to synchronously open file
	test/accuracy_test.py::test_glove_25
	test/accuracy_test.py::test_fashion_mnist
)

python_prepare_all() {
	sed -i "/setup_requires/d" setup.py || die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

python_compile_all() {
	use test && esetup.py build_ext --inplace
}

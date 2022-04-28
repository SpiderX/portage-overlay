# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Approximate Nearest Neighbors in C++/Python"
HOMEPAGE="https://github.com/spotify/annoy"
SRC_URI="https://github.com/spotify/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
PROPERTIES="test_network"

BDEPEND="dev-python/nose[${PYTHON_USEDEP}]
	test? ( dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}] )"

distutils_enable_tests nose

python_compile_all() {
	use test && esetup.py build_ext --inplace
}

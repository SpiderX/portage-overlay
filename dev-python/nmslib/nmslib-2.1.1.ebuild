# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Non-Metric Space Library"
HOMEPAGE="https://github.com/nmslib/nmslib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pybind11[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	# fix QA
	sed -i '/description/s/-/_/' setup.cfg \
		|| die "sed failed"
	# relax dependency version
	sed -i '/dep_list = /s|<|>=|' setup.py \
		|| die "sed failed for setup.py"
	# fix import
	sed -i '/ nmslibLogger /s|module|object|' nmslib.cc \
		|| die "sed failed for nmslib.cc"

	distutils-r1_python_prepare_all
}

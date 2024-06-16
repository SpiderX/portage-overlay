# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
EGIT_REPO_URI="https://github.com/nmslib/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Non-Metric Space Library"
HOMEPAGE="https://github.com/nmslib/nmslib"
S="${WORKDIR}/${P}/python_bindings"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test" # fails

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pybind11[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	# fix import
	sed -i '/sklearn.datasets/s|.samples_generator||' \
		notebooks/test_hnsw_recall.py || die "sed failed for test_hnsw_recall.py"

	distutils-r1_python_prepare_all
}

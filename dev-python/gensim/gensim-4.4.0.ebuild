# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 edo

DESCRIPTION="Topic Modelling for Humans"
HOMEPAGE="https://github.com/piskvorky/gensim"
SRC_URI="https://github.com/piskvorky/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/smart-open[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	test? ( dev-python/annoy[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nbconvert[${PYTHON_USEDEP}]
		dev-python/nbformat[${PYTHON_USEDEP}]
		dev-python/nmslib[${PYTHON_USEDEP}]
		dev-python/pyemd[${PYTHON_USEDEP}]
		dev-python/testfixtures[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
EPYTEST_PLUGINS=()
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	gensim/test/test_similarities.py::TestWord2VecAnnoyIndexer::test_annoy_indexing_of_keyed_vectors
	gensim/test/test_similarities.py::TestWord2VecAnnoyIndexer::test_fast_text
	gensim/test/test_similarities.py::TestWord2VecAnnoyIndexer::test_word2vec
	gensim/test/test_similarities.py::TestDoc2VecAnnoyIndexer::test_save
)

python_compile() {
	distutils-r1_python_compile
	use test && esetup.py build_ext --inplace
}

python_install_all() {
	distutils-r1_python_install_all
	edo find "${ED}" -type d -name "test" -exec rm -rv {} +
}

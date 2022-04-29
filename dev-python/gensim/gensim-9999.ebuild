# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/RaRe-Technologies/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Topic Modelling for Humans"
HOMEPAGE="https://github.com/RaRe-Technologies/gensim"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/smart_open[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	test? ( dev-python/annoy[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nbconvert[${PYTHON_USEDEP}]
		dev-python/nbformat[${PYTHON_USEDEP}]
		dev-python/nmslib[${PYTHON_USEDEP}]
		dev-python/pyemd[${PYTHON_USEDEP}]
		dev-python/testfixtures[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# assertionError: False is not true
	gensim/test/test_similarities.py::TestWord2VecAnnoyIndexer::test_annoy_indexing_of_keyed_vectors
	gensim/test/test_similarities.py::TestWord2VecAnnoyIndexer::test_fast_text
	gensim/test/test_similarities.py::TestWord2VecAnnoyIndexer::test_word2vec
	gensim/test/test_similarities.py::TestDoc2VecAnnoyIndexer::test_save
)

python_prepare_all() {
	# relax dependency version, fix build
	sed -i  -e '/CYTHON_STR/s|==|>=|' \
		-e '/import sys/aimport builtins' \
		-e '/NUMPY_SETUP/s|__||g' setup.py \
		|| die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

python_compile() {
	distutils-r1_python_compile "$(usex test '-i' '-v')"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "test" -exec rm -rv {} + || die "test removing failed"
}

pkg_postinst() {
	optfeature "similarity measure" dev-python/python-levenshtein
	optfeature "distributed environment" dev-python/Pyro4
}

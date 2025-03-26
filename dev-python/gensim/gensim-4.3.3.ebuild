# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature

DESCRIPTION="Topic Modelling for Humans"
HOMEPAGE="https://github.com/piskvorky/gensim"
SRC_URI="https://github.com/piskvorky/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

# lsimodel requires <=dev-python/scipy-1.13.1
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
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# ValueError: could not convert string to float
	gensim/test/test_keyedvectors.py::TestKeyedVectors::test_no_header
	gensim/test/test_keyedvectors.py::TestKeyedVectors::test_save_reload
	gensim/test/test_fasttext.py::TestWord2VecModel::test_persistence_word2vec_format_non_binary
	gensim/test/test_word2vec.py::TestWord2VecModel::test_persistence_word2vec_format_non_binary
	gensim/test/test_doc2vec.py::TestDoc2VecModel::test_persistence_word2vec_format
	gensim/test/test_fasttext.py::TestWord2VecModel::test_too_short_text_word2vec_format
	gensim/test/test_word2vec.py::TestWord2VecModel::test_too_short_text_word2vec_format
	# AssertionError
	gensim/test/test_ldamodel.py::TestLdaModel::test_alpha_auto
	gensim/test/test_ldamodel.py::TestLdaModel::test_eta_auto
	gensim/test/test_ldamodel.py::TestLdaMulticore::test_eta_auto
	gensim/test/test_glove2word2vec.py::TestGlove2Word2Vec::test_conversion
	gensim/test/test_fasttext.py::TestWord2VecModel::test_similarities
	gensim/test/test_word2vec.py::TestWord2VecModel::test_similarities
	gensim/test/test_similarities.py::TestWord2VecAnnoyIndexer::test_fast_text
	gensim/test/test_similarities.py::TestWord2VecAnnoyIndexer::test_word2vec
	gensim/test/test_similarities.py::TestDoc2VecAnnoyIndexer::test_save
	gensim/test/test_similarities.py::TestWord2VecAnnoyIndexer::test_annoy_indexing_of_keyed_vectors
	# AttributeError: `scipy.sparse.sparsetools` is deprecated
	gensim/test/test_lee.py::TestLeeTest::test_lee
	gensim/test/test_lsimodel.py::TestLsiModel::test_corpus_transform
	gensim/test/test_lsimodel.py::TestLsiModel::test_docs_processed
	gensim/test/test_lsimodel.py::TestLsiModel::test_get_topics
	gensim/test/test_lsimodel.py::TestLsiModel::test_large_mmap
	gensim/test/test_lsimodel.py::TestLsiModel::test_large_mmap_compressed
	gensim/test/test_lsimodel.py::TestLsiModel::test_online_transform
	gensim/test/test_lsimodel.py::TestLsiModel::test_persistence
	gensim/test/test_lsimodel.py::TestLsiModel::test_persistence_compressed
	gensim/test/test_lsimodel.py::TestLsiModel::test_print_topic
	gensim/test/test_lsimodel.py::TestLsiModel::test_print_topics
	gensim/test/test_lsimodel.py::TestLsiModel::test_show_topic
	gensim/test/test_lsimodel.py::TestLsiModel::test_show_topics
	gensim/test/test_lsimodel.py::TestLsiModel::test_transform
	gensim/test/test_lsimodel.py::TestLsiModel::test_transform_float32
)

python_compile() {
	distutils-r1_python_compile
	use test && esetup.py build_ext --inplace
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "test" -exec rm -rv {} + || die "test removing failed"
}

pkg_postinst() {
	optfeature "similarity measure" dev-python/python-levenshtein
	optfeature "distributed environment" dev-python/Pyro4
}

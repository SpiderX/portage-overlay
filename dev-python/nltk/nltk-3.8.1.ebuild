# Copyright 1999-2043 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="sqlite,tk?,xml(+)"

inherit distutils-r1

DESCRIPTION="Natural Language Toolkit"
HOMEPAGE="https://github.com/nltk/nltk"
SRC_URI="https://github.com/nltk/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tk"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/joblib[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/nltk-data
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pyparsing[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/scikit-learn[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/twython[${PYTHON_USEDEP}] )"
PDEPEND="dev-python/nltk-data"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# TypeError: Fraction.__new__() got an unexpected keyword argument '_normalize'
	nltk/test/unit/translate/test_bleu.py::TestBLEU::test_full_matches
	nltk/test/unit/translate/test_bleu.py::TestBLEU::test_modified_precision
	nltk/test/unit/translate/test_bleu.py::TestBLEU::test_partial_matches_hypothesis_longer_than_reference
	nltk/test/unit/translate/test_bleu.py::TestBLEU::test_zero_matches
	nltk/test/unit/translate/test_bleu.py::TestBLEUFringeCases::test_case_where_n_is_bigger_than_hypothesis_length
	nltk/test/unit/translate/test_bleu.py::TestBLEUFringeCases::test_empty_hypothesis
	nltk/test/unit/translate/test_bleu.py::TestBLEUFringeCases::test_empty_references
	nltk/test/unit/translate/test_bleu.py::TestBLEUFringeCases::test_empty_references_and_hypothesis
	nltk/test/unit/translate/test_bleu.py::TestBLEUFringeCases::test_length_one_hypothesis
	nltk/test/unit/translate/test_bleu.py::TestBLEUFringeCases::test_reference_or_hypothesis_shorter_than_fourgrams
	nltk/test/unit/translate/test_bleu.py::TestBLEUvsMteval13a::test_corpus_bleu
	nltk/test/unit/translate/test_bleu.py::TestBLEUWithBadSentence::test_corpus_bleu_with_bad_sentence
	nltk/test/unit/translate/test_bleu.py::TestBLEUWithMultipleWeights::test_corpus_bleu_with_multiple_weights
)

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )
PYTHON_REQ_USE="sqlite,tk?,xml(+)"

inherit distutils-r1 git-r3

DESCRIPTION="Natural Language Toolkit"
HOMEPAGE="https://github.com/nltk/nltk"
EGIT_REPO_URI="https://github.com/nltk/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test tk"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/joblib[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/nltkdata
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pyparsing[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/scikit-learn[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/twython[${PYTHON_USEDEP}] )"
PDEPEND="dev-python/nltkdata"

distutils_enable_tests pytest

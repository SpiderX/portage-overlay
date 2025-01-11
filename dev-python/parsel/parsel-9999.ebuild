# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
EGIT_REPO_URI="https://github.com/scrapy/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Utility to extract data from XML/HTML documents using XPath or CSS selectors"
HOMEPAGE="https://github.com/scrapy/parsel"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/cssselect[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/w3lib[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/sybil[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

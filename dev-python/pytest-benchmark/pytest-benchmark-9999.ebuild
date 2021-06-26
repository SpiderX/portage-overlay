# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
EGIT_REPO_URI="https://github.com/ionelmc/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="py.test fixture for benchmarking code"
HOMEPAGE="https://github.com/ionelmc/pytest-benchmark"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # fails

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/py-cpuinfo[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/aspectlib[${PYTHON_USEDEP}]
		dev-python/elasticsearch-py[${PYTHON_USEDEP}]
		dev-python/pygal[${PYTHON_USEDEP}]
		dev-python/pygal[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "integration with Elasticsearch" dev-python/elasticsearch-py
	optfeature "support of histogram" dev-python/pygal dev-python/pygaljs
	optfeature "support of aspect" dev-python/aspectlib
}

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python interface for igraph"
HOMEPAGE="https://github.com/igraph/python-igraph"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-libs/igraph
	dev-python/texttable[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/cairocffi[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/networkx[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/plotly[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}] )"
#dev-python/graph-tool no python3_13

distutils_enable_tests pytest

python_compile() {
	distutils-r1_python_compile --use-pkg-config
}

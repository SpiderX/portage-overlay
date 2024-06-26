# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

MY_PN="python-${PN}"

DESCRIPTION="Python interface for igraph"
HOMEPAGE="https://github.com/igraph/python-igraph"
SRC_URI="https://github.com/igraph/${MY_PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/igraph
	dev-python/texttable[${PYTHON_USEDEP}]"
BDEPEND="test? (
		dev-python/cairocffi[${PYTHON_USEDEP}]
		dev-python/graph-tool[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/networkx[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/plotly[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# matplotlib.testing.exceptions.ImageComparisonFailure: images not close
	tests/drawing/matplotlib/test_graph.py::GraphTestRunner::test_labels
)

python_prepare_all() {
	rm README.md || die "remove README.md failed"

	# fix the igraph include path
	pushd src || die "pushd failed"
	find -type f -name "*.h" -exec sed -i -e 's@#include <igraph@#include <igraph/igraph@g' {} + \
		|| die "sed failed for .h"
	find -type f -name "*.c" -exec sed -i -e 's@#include <igraph@#include <igraph/igraph@g' {} + \
		|| die "sed failed for .c"
	popd || die "popd failed"

	distutils-r1_python_prepare_all
}

python_compile() {
	distutils-r1_python_compile --use-pkg-config
}

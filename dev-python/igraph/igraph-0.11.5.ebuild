# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Python interface for igraph"
HOMEPAGE="https://github.com/igraph/python-igraph"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=">=dev-libs/igraph-0.10.11:0=
	dev-python/texttable[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/cairocffi[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/networkx[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/plotly[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-timeout )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# SystemError
	tests/test_basic.py::BasicTests::testAdjacency
	tests/test_basic.py::BasicTests::testEdgeIncidence
	tests/test_conversion.py::GraphRepresentationTests::testGetAdjacency
	tests/test_conversion.py::GraphRepresentationTests::testGetAdjacencyRoundtrip
	tests/test_conversion.py::GraphRepresentationTests::testGetSparseAdjacency
	tests/test_foreign.py::ForeignTests::testAdjacency
	tests/test_games.py::GameTests::testRewire
	tests/test_generators.py::GeneratorTests::testRealizeDegreeSequence
	tests/test_homepage.py::HomepageExampleTests::testKautz
	tests/test_iterators.py::IteratorTests::testDFS
	tests/test_structural.py::DegreeTests::testDegree
	tests/test_structural.py::DegreeTests::testMaxDegree
	tests/test_structural.py::DegreeTests::testStrength
	tests/test_structural.py::CentralityTests::testAuthorityScore
	tests/test_structural.py::CentralityTests::testHubScore
	tests/test_structural.py::MiscTests::testTopologicalSorting
	tests/test_structural.py::DominatorTests::testDominators
	tests/test_vertexseq.py::VertexTests::testIncident
	tests/test_vertexseq.py::VertexTests::testProxyMethods
)

export IGRAPH_USE_PKG_CONFIG=1

pkg_postinst() {
	optfeature "plotting with Cairo" dev-python/cairocffi
	optfeature "plotting with Matplotlib" dev-python/matplotlib
	optfeature "plotting with Plotly" dev-python/plotly
}

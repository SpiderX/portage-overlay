# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Neo4j Bolt driver for Python"
HOMEPAGE="https://github.com/neo4j/neo4j-python-driver"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-python/pytz[${PYTHON_USEDEP}]"
BDEPEND="dev-python/tomlkit[${PYTHON_USEDEP}]
	test? ( dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pyarrow[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# ignore integration and performance tests
	tests/integration
	tests/performance
)

pkg_postinst() {
	optfeature "support numpy" dev-python/numpy
	optfeature "support pandas" dev-python/numpy dev-python/pandas
	optfeature "support pyarrow" dev-python/pyarrow
}

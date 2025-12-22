# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="The shared semantic layer definitions that dbt-core and MetricFlow use"
HOMEPAGE="https://github.com/dbt-labs/dbt-semantic-interfaces"
EGIT_REPO_URI="https://github.com/dbt-labs/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="<dev-python/click-8.3[${PYTHON_USEDEP}]
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/more-itertools[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
distutils_enable_tests pytest

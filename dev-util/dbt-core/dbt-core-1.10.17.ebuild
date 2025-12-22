# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="With dbt, build analytics the way engineers build applications"
HOMEPAGE="https://github.com/dbt-labs/dbt-core"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # no tests

RDEPEND="dev-python/agate[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/daff[${PYTHON_USEDEP}]
	dev-python/dbt-adapters[${PYTHON_USEDEP}]
	dev-python/dbt-common[${PYTHON_USEDEP}]
	dev-python/dbt-protos[${PYTHON_USEDEP}]
	dev-python/dbt-semantic-interfaces[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/networkx[${PYTHON_USEDEP}]
	dev-python/mashumaro[${PYTHON_USEDEP}]
	dev-python/msgpack[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pathspec[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/snowplow-tracker[${PYTHON_USEDEP}]
	dev-python/sqlparse[${PYTHON_USEDEP}]
	dev-util/dbt-extractor[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-db/postgresql:*
		dev-python/dbt-postgres[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-mock )
distutils_enable_tests pytest

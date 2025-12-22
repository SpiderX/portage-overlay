# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 edo pypi

DESCRIPTION="The dbt adapter used to transform data loaded into a PostgreSQL"
HOMEPAGE="https://github.com/dbt-labs/dbt-adapters"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/agate[${PYTHON_USEDEP}]
	dev-python/dbt-adapters[${PYTHON_USEDEP}]
	dev-python/dbt-common[${PYTHON_USEDEP}]
	dev-python/psycopg:2[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-db/postgresql:*
		dev-vcs/git
		dev-python/dbt-tests-adapter[${PYTHON_USEDEP}]
		dev-python/freezegun[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
EPYTEST_PLUGINS=( pytest-mock )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Failed: DID NOT RAISE
	tests/functional/exposures/test_exposure_configs.py::TestInvalidConfig::test_exposure_config_yaml_level
	tests/functional/invalid_model_tests/test_invalid_models.py::TestMalformedEnabledParam::test_view_disabled
	tests/functional/sources/test_source_configs.py::TestInvalidSourceConfig::test_invalid_config_source
)

python_test() {
	# tests/functional/conftest.py
	export PGPASSWORD='password' DBT_TEST_USER_1=dbt_test_user_1 \
		DBT_TEST_USER_2=dbt_test_user_2 DBT_TEST_USER_3=dbt_test_user_3
	local db="${T}/pgsql"
	edo initdb -U postgres -A trust -D "${db}"
	edo pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'"
	edo psql -h "${T}" -U postgres -f scripts/setup_test_database.sql
	epytest -s tests/unit
	epytest -s tests/functional
	edo pg_ctl -w -D "${db}" stop
}

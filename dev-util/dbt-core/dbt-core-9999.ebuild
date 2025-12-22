# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 edo git-r3

DESCRIPTION="With dbt, build analytics the way engineers build applications"
HOMEPAGE="https://github.com/dbt-labs/dbt-core"
EGIT_REPO_URI="https://github.com/dbt-labs/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

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

EPYTEST_DESELECT=(
	# AssertionError
	tests/unit/contracts/graph/test_unparsed.py::TestUnparsedModelUpdate::test_contents
	tests/unit/contracts/graph/test_unparsed.py::TestUnparsedVersion::test_ok
)
EPYTEST_IGNORE=( tests/unit/graph/test_selector_methods.py )

python_prepare_all() {
	# remove env_files
	sed -i '/env_files/,+1d' pytest.ini || die "sed failed for pytest.ini"

	distutils-r1_python_prepare_all
}

src_compile() {
	edo cd core
	distutils-r1_src_compile
}

python_test() {
	# core/hatch.toml
	export PGPASSWORD='password' DBT_TEST_USER_1=dbt_test_user_1 \
		DBT_TEST_USER_2=dbt_test_user_2 DBT_TEST_USER_3=dbt_test_user_3
	local db="${T}/pgsql"
	edo initdb -U postgres -A trust -D "${db}"
	edo pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'"
	# scripts/setup_db.sh
	edo createdb -h "${T}" -U postgres dbt
	edo psql -h "${T}" -U postgres -c "CREATE ROLE root WITH PASSWORD 'password';"
	edo psql -h "${T}" -U postgres -c "ALTER ROLE root WITH LOGIN;"
	edo psql -h "${T}" -U postgres -c "GRANT CREATE, CONNECT ON DATABASE dbt TO root WITH GRANT OPTION;"
	edo psql -h "${T}" -U postgres -c "CREATE ROLE noaccess WITH PASSWORD 'password' NOSUPERUSER;"
	edo psql -h "${T}" -U postgres -c "ALTER ROLE noaccess WITH LOGIN;"
	edo psql -h "${T}" -U postgres -c "GRANT CONNECT ON DATABASE dbt TO noaccess;"
	edo psql -h "${T}" -U postgres -c "CREATE ROLE dbt_test_user_1;"
	edo psql -h "${T}" -U postgres -c "CREATE ROLE dbt_test_user_2;"
	edo psql -h "${T}" -U postgres -c "CREATE ROLE dbt_test_user_3;"
	edo psql -h "${T}" -U postgres -c 'CREATE DATABASE "dbtMixedCase";'
	edo psql -h "${T}" -U postgres -c 'GRANT CREATE, CONNECT ON DATABASE "dbtMixedCase" TO root WITH GRANT OPTION;'
	epytest -s tests/unit
	edo pg_ctl -w -D "${db}" stop
}

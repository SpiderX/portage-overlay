# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 edo git-r3

DESCRIPTION="Smart object creation facility for Django"
HOMEPAGE="https://github.com/model-bakers/model_bakery"
EGIT_REPO_URI="https://github.com/model-bakers/model_bakery.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-db/postgis
		dev-db/postgresql:* )"

EPYTEST_PLUGINS=( pytest-django )

distutils_enable_tests pytest

src_prepare() {
	default

	# remove addopts
	sed -i '/addopts/d' pyproject.toml || die "sed failed for pyproject.toml"
}

python_test() {
	export TEST_DB=postgis PGUSER=postgres
	local db="${T}/pgsql"
	edo initdb -U postgres -A trust -D "${db}"
	edo pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'"
	edo psql -U postgres -h 127.0.0.1 template1 -c "CREATE EXTENSION IF NOT EXISTS postgis;"
	edo psql -U postgres -h 127.0.0.1 template1 -c "CREATE EXTENSION IF NOT EXISTS hstore;"
	edo psql -U postgres -h 127.0.0.1 template1 -c "CREATE EXTENSION IF NOT EXISTS citext;"
	epytest
	edo pg_ctl -w -D "${db}" stop
}

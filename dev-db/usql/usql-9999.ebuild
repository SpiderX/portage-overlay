# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/xo/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Universal command-line interface for SQL databases"
HOMEPAGE="https://github.com/xo/usql"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="athena avatica bigquery cassandra clickhouse cosmos couchbase csvq firebird
	genji h2 hdb hive ignite impala maxcompute +mssql +mysql netezza +oracle
	+postgres presto ql snowflake spanner +sqlite tds trino vertica voltdb"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-X github.com/xo/usql/text.CommandName=${PN} -X github.com/xo/usql/text.CommandVersion=${PV}"
	TAGS="netgo $(usex athena athena no_athena) $(usex avatica avatica no_avatica)
		$(usex bigquery bigquery no_bigquery) $(usex cassandra cassandra no_cassandra)
		$(usex clickhouse clickhouse no_clickhouse) $(usex cosmos cosmos no_cosmos)
		$(usex couchbase couchbase no_couchbase) $(usex csvq csvq no_csvq)
		$(usex firebird firebird no_firebird) $(usex genji genji no_genji) $(usex h2 h2 no_h2)
		$(usex hdb hdb no_hdb) $(usex hive hive no_hive) $(usex ignite ignite no_ignite)
		$(usex impala impala no_impala) $(usex maxcompute maxcompute no_maxcompute)
		$(usex mssql sqlserver no_sqlserver) $(usex mysql 'mysql mymysql' 'no_mysql no_mymysql')
		$(usex netezza netezza no_netezza) $(usex oracle 'godror oracle' 'no_godror' no_oracle)
		$(usex postgres 'pgx postgres' 'no_pgx no_postgres') $(usex presto presto no_presto)
		$(usex ql ql no_ql) $(usex snowflake snowflake no_snowflake) $(usex spanner spanner no_spanner)
		$(usex sqlite 'moderncsqlite sqlite3 sqlite sqlite_app_armor sqlite_fts5 sqlite_introspect sqlite_json1 sqlite_stat4 sqlite_userauth sqlite_vtable sqlite_icu' 'no_moderncsqlite no_sqlite3')
		$(usex tds tds no_tds) $(usex trino trino no_trino) $(usex vertica vertica no_vertica)
		$(usex voltdb voltdb no_voltdb) no_adodb"
	go build -tags "${TAGS}" -ldflags="${LDFLAGS}" || die "build failed"
}

src_test() {
	go test || die "test failed"
}

src_install() {
	einstalldocs
	dobin usql
}

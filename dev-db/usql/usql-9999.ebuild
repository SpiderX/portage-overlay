# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Universal command-line interface for SQL databases"
HOMEPAGE="https://github.com/xo/usql"
EGIT_REPO_URI="https://github.com/xo/${PN}.git"

LICENSE="MIT"
SLOT="0"
IUSE="athena avatica bigquery cassandra chai clickhouse cosmos couchbase csvq databend databricks
	duckdb dynamodb exasol firebird flightsql h2 hdb hive ignite impala maxcompute +mssql
	+mysql netezza +oracle odbc +postgres presto ql ramsql sapase saphana snowflake spanner
	+sqlite tablestore tds trino vertica voltdb ydb"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-X github.com/xo/usql/text.CommandName=${PN} -X github.com/xo/usql/text.CommandVersion=${PV}"
	TAGS="netgo $(usex athena athena no_athena) $(usex avatica avatica no_avatica)
		$(usex bigquery bigquery no_bigquery) $(usex cassandra cassandra no_cassandra)
		$(usex chai chai no_chai) $(usex clickhouse clickhouse no_clickhouse)
		$(usex cosmos cosmos no_cosmos) $(usex couchbase couchbase no_couchbase) $(usex csvq csvq no_csvq)
		$(usex databend databend no_databend)
		$(usex databricks databricks no_databricks) $(duckdb duckdb no_duckdb)
		$(usex dynamodb dynamodb no_dynamodb) $(usex exasol exasol no_exasol)
		$(usex firebird firebird no_firebird) $(flightsql flightsql no_flightsql) $(usex h2 h2 no_h2)
		$(usex hdb hdb no_hdb) $(usex hive hive no_hive) $(usex ignite ignite no_ignite)
		$(usex impala impala no_impala) $(usex maxcompute maxcompute no_maxcompute)
		$(usex mssql sqlserver no_sqlserver) $(usex mysql 'mysql mymysql' 'no_mysql no_mymysql')
		$(usex netezza netezza no_netezza) $(odbc odbc no_odbc)
		$(usex oracle 'godror oracle' 'no_godror' no_oracle)
		$(usex postgres 'pgx postgres' 'no_pgx no_postgres') $(usex presto presto no_presto)
		$(usex ramsql ramsql no_ramsql) $(usex ql ql no_ql) $(usex snowflake snowflake no_snowflake)
		$(usex spanner spanner no_spanner) $(usex tablestore ots no_ots) $(usex sapase sapase no_sapase)
		$(usex saphana saphana no_saphana)
		$(usex sqlite 'moderncsqlite sqlite3 sqlite sqlite_app_armor sqlite_fts5 sqlite_introspect sqlite_json1 sqlite_stat4 sqlite_userauth sqlite_vtable sqlite_icu' 'no_moderncsqlite no_sqlite3')
		$(usex tds tds no_tds) $(usex trino trino no_trino) $(usex vertica vertica no_vertica)
		$(usex voltdb voltdb no_voltdb) $(ydb ydb no_ydb) no_adodb"
	ego build -tags "${TAGS}" -ldflags="${LDFLAGS}"
}

src_test() {
	ego test
}

src_install() {
	einstalldocs
	dobin usql
}

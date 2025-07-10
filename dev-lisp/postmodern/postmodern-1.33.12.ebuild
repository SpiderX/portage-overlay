# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

DESCRIPTION="A Common Lisp PostgreSQL programming interface"
HOMEPAGE="https://marijnhaverbeke.nl/postmodern/"
SRC_URI="https://github.com/marijnh/${PN^}/archive/v${PV}.tar.gz -> ${P^}.tar.gz"
S="${WORKDIR}/${P^}"

LICENSE="MIT POSTGRESQL ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl test"
RESTRICT="!test? ( test )" # Fail: 7

RDEPEND="dev-lisp/asdf-system-connections
	dev-lisp/alexandria
	dev-lisp/bordeaux-threads
	dev-lisp/cl-base64
	dev-lisp/closer-mop
	dev-lisp/ironclad
	dev-lisp/global-vars
	dev-lisp/md5
	dev-lisp/split-sequence
	dev-lisp/uax15
	dev-lisp/usocket
	ssl? ( dev-lisp/cl-plus-ssl )"
BDEPEND="dev-lisp/asdf
	test? ( dev-db/postgresql:17[server]
		dev-lisp/fiveam
		dev-lisp/local-time
		dev-lisp/trivial-octet-streams )"

DOCS=( {CHANGELOG,README}.md )

src_test() {
	local db="${T}/pgsql"
	local DB_NAME="test" DB_USER="test" DB_PASS="test" DB_HOST="localhost" \
		DB_PORT="5432" USE_SSL="NO"
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	initdb --username=test -D "${db}" || die "initdb failed"
	pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'" \
		|| die "pg_ctl for start failed"
	psql -h "${T}" -U test -d postgres \
		-c "ALTER ROLE test WITH PASSWORD 'test';" \
		|| die "psql failed"
	createdb -h "${T}" -U test test || die "createdb failed"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :postmodern)" \
		|| die "test failed"

	pg_ctl -w -D "${db}" stop || die "pg_ctl for stop failed"
}

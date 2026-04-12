# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
POSTGRES_COMPAT=( {14..18} )
POSTGRES_USEDEP="server,xml"

inherit edo haskell-cabal postgres readme.gentoo-r1 systemd

DESCRIPTION="REST API for any Postgres database"
HOMEPAGE="https://github.com/PostgREST/postgrest"
SRC_URI="https://github.com/PostgREST/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="acct-group/postgrest
	acct-user/postgrest
	dev-haskell/aeson:=[profile?]
	dev-haskell/auto-update:=[profile?]
	dev-haskell/base64-bytestring:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/cassava:=[profile?]
	dev-haskell/configurator-pg:=[profile?]
	dev-haskell/cookie:=[profile?]
	dev-haskell/either:=[profile?]
	dev-haskell/extra:=[profile?]
	dev-haskell/focus:=[profile?]
	dev-haskell/fuzzyset:=[profile?]
	dev-haskell/hasql:=[profile?]
	dev-haskell/hasql-dynamic-statements:=[profile?]
	dev-haskell/hasql-notifications:=[profile?]
	dev-haskell/hasql-pool:=[profile?]
	dev-haskell/hasql-transaction:=[profile?]
	dev-haskell/http:=[profile?]
	dev-haskell/http-client:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/insert-ordered-containers:=[profile?]
	dev-haskell/jose-jwt:=[profile?]
	dev-haskell/lens:=[profile?]
	dev-haskell/lens-aeson:=[profile?]
	dev-haskell/neat-interpolation:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/network-uri:=[profile?]
	dev-haskell/optparse-applicative:=[profile?]
	dev-haskell/parsec:=[profile?]
	dev-haskell/postgresql-libpq:=[profile?]
	dev-haskell/prometheus-client:=[profile?]
	dev-haskell/protolude:=[profile?]
	dev-haskell/ranged-sets:=[profile?]
	dev-haskell/regex-tdfa:=[profile?]
	dev-haskell/retry:=[profile?]
	dev-haskell/scientific:=[profile?]
	dev-haskell/some:=[profile?]
	dev-haskell/stm-hamt:=[profile?]
	dev-haskell/streaming-commons:=[profile?]
	dev-haskell/swagger2:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-haskell/unix-compat-0.7:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/vault:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-haskell/wai:=[profile?]
	dev-haskell/wai-cors:=[profile?]
	>=dev-haskell/wai-extra-3.1.13.0:=[profile?]
	>=dev-haskell/wai-logger-2.4.0:=[profile?]
	dev-haskell/warp:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"

BDEPEND="dev-haskell/cabal:=
	test? ( ${POSTGRES_DEP}
		dev-db/pg-safeupdate
		dev-db/postgis
		dev-haskell/aeson-qq:=[profile?]
		dev-haskell/async:=[profile?]
		dev-haskell/doctest:=[profile?]
		dev-haskell/heredoc:=[profile?]
		dev-haskell/hspec:=[profile?]
		dev-haskell/hspec-expectations:=[profile?]
		dev-haskell/hspec-wai:=[profile?]
		dev-haskell/hspec-wai-json:=[profile?]
		dev-haskell/http-types:=[profile?]
		dev-haskell/monad-control:=[profile?]
		dev-haskell/pretty-simple:=[profile?]
		dev-haskell/transformers-base:=[profile?] )"

DOC_CONTENTS="Sample configuration: /etc/postgrest/postgrest.conf.sample.
Copy it to /etc/postgrest/postgrest.conf to run PostgREST."

CABAL_CHDEPS=(
	'hasql-notifications       >= 0.2.2.2 && < 0.2.3' 'hasql-notifications       >= 0.2.0.6 && < 0.2.3'
	'http-client               >= 0.7.19 && < 0.8' 'http-client               >= 0.7.14 && < 0.8'
	'streaming-commons         >= 0.2.3.1 && < 0.3' 'streaming-commons         >= 0.2.2.5 && < 0.3'
)

pkg_setup() {
	haskell-cabal_pkg_setup
	postgres_pkg_setup
}

src_prepare() {
	haskell-cabal_src_prepare

	sed -i  -e '/license-file/d' \
		-e '/ghc-options:        /s/-Werror //' \
		-e '/                      -O2/s/-Werror //' \
		postgrest.cabal || die "sed for postgrest.cabal failed"
}

src_test() {
	local db="${T}/pgsql"
	# test has hardcoded 'postgres' user
	export PGHOST="${T}" PGUSER="postgres" PGDATABASE="postgres"

	edo initdb -U postgres -D "${db}"
	# test expects UTC timezone
	sed -i '/timezone/s|Europe/Kiev|UTC|' "${db}"/postgresql.conf \
		|| die "sed for postgresql.conf failed"
	edo pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'"
	# load fixtures into database
	edo psql --set=PGUSER="postgres" -v ON_ERROR_STOP=1 \
		-f test/spec/fixtures/load.sql

	haskell-cabal_src_test

	edo pg_ctl -w -D "${db}" stop
}

src_install() {
	echo "LD_LIBRARY_PATH is ${LD_LIBRARY_PATH}, ED is ${ED}"
	export LD_LIBRARY_PATH="${ED}${LD_LIBRARY_PATH}:${LD_LIBRARY_PATH}"
	haskell-cabal_src_install

	newinitd "${FILESDIR}"/postgrest.initd postgrest
	newconfd "${FILESDIR}"/postgrest.confd postgrest
	systemd_dounit "${FILESDIR}"/postgrest.service

	readme.gentoo_create_doc

	# generate sample config
	insopts -o postgrest -g postgrest -m 0644
	insinto /etc/postgrest
	newins - postgrest.conf.sample < <("${ED}"/usr/bin/postgrest -e \
		|| die "posgrest failed for postgrest.conf.sample" )
	diropts -o postgrest -g postgrest -m 0750
	keepdir /var/log/postgrest
}

pkg_postinst() {
	haskell-cabal_pkg_postinst
	readme.gentoo_print_elog
}

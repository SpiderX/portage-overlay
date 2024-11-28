# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal readme.gentoo-r1 systemd

DESCRIPTION="REST API for any Postgres database"
HOMEPAGE="https://github.com/PostgREST/postgrest"
SRC_URI="https://github.com/PostgREST/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="acct-user/postgrest
	dev-haskell/aeson:=[profile?]
	dev-haskell/auto-update:=[profile?]
	dev-haskell/base64-bytestring:=[profile?]
	dev-haskell/cache:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/cassava:=[profile?]
	>=dev-haskell/clock-0.8.3:=[profile?]
	dev-haskell/configurator-pg:=[profile?]
	dev-haskell/contravariant-extras:=[profile?]
	dev-haskell/cookie:=[profile?]
	dev-haskell/either:=[profile?]
	dev-haskell/extra:=[profile?]
	dev-haskell/fuzzyset:=[profile?]
	dev-haskell/gitrev:=[profile?]
	dev-haskell/hasql:=[profile?]
	dev-haskell/hasql-dynamic-statements:=[profile?]
	dev-haskell/hasql-notifications:=[profile?]
	dev-haskell/hasql-pool:=[profile?]
	dev-haskell/hasql-transaction:=[profile?]
	dev-haskell/heredoc:=[profile?]
	dev-haskell/http:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/insert-ordered-containers:=[profile?]
	dev-haskell/interpolatedstring-perl6:=[profile?]
	dev-haskell/jose:=[profile?]
	dev-haskell/lens:=[profile?]
	dev-haskell/lens-aeson:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/network-uri:=[profile?]
	dev-haskell/optparse-applicative:=[profile?]
	dev-haskell/parsec:=[profile?]
	dev-haskell/protolude:=[profile?]
	dev-haskell/ranged-sets:=[profile?]
	dev-haskell/regex-tdfa:=[profile?]
	dev-haskell/retry:=[profile?]
	dev-haskell/scientific:=[profile?]
	dev-haskell/streaming-commons:=[profile?]
	dev-haskell/swagger2:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/timeit:=[profile?]
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
	test? ( dev-db/pg-safeupdate
		dev-db/postgis
		dev-db/postgresql:*[xml]
		dev-haskell/aeson-qq:=[profile?]
		dev-haskell/async:=[profile?]
		dev-haskell/doctest:=[profile?]
		dev-haskell/hspec:=[profile?]
		dev-haskell/hspec-wai:=[profile?]
		dev-haskell/hspec-wai-json:=[profile?]
		dev-haskell/monad-control:=[profile?]
		dev-haskell/pretty-simple:=[profile?]
		dev-haskell/transformers-base:=[profile?] )"

PATCHES=( "${FILESDIR}/${PN}"-12.0.3-psql-17-fixtures.patch )

DOC_CONTENTS="Sample configuration: /etc/postgrest/postgrest.conf.sample.
Copy it to /etc/postgrest/postgrest.conf to run PostgREST."

CABAL_CHDEPS=(
	'auto-update               >= 0.1.4 && < 0.2' 'auto-update               >= 0.1.4'
	'auto-update       >= 0.1.4 && < 0.2' 'auto-update       >= 0.1.4'
	'optparse-applicative      >= 0.13 && < 0.18' 'optparse-applicative      >= 0.13'
	'unix-compat               >= 0.5.4 && < 0.6' 'unix-compat               >= 0.5.4'
	'warp                      >= 3.3.19 && < 3.4' 'warp                      >= 3.3.19'
	'hspec             >= 2.3 && < 2.10' 'hspec             >= 2.3'
)

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

	initdb -U postgres -D "${db}" || die "initdb failed"
	# test expects UTC timezone
	sed -i '/timezone/s|Europe/Kiev|UTC|' "${db}"/postgresql.conf \
		|| die "sed for postgresql.conf failed"
	pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'" \
		|| die "pg_ctl for start failed"
	# load fixtures into database
	psql --set=PGUSER="postgres" -v ON_ERROR_STOP=1 \
		-f test/spec/fixtures/load.sql || die "psql failed"

	haskell-cabal_src_test

	pg_ctl -w -D "${db}" stop || die "pg_ctl for stop failed"
}

src_install() {
	echo "LD_LIBRARY_PATH is ${LD_LIBRARY_PATH}, ED is ${ED}"
	export LD_LIBRARY_PATH="${ED}${LD_LIBRARY_PATH}:${LD_LIBRARY_PATH}"
	haskell-cabal_src_install

	newinitd "${FILESDIR}"/postgrest.initd postgrest
	newconfd "${FILESDIR}"/postgrest.confd postgrest
	systemd_dounit "${FILESDIR}"/postgrest.service

	readme.gentoo_create_doc

	# Generate sample config
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

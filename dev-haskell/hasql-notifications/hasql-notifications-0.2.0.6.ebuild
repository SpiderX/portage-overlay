# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="PostgreSQL Asynchronous notification"
HOMEPAGE="https://github.com/diogob/hasql-notifications"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/hasql:=[profile?]
	dev-haskell/hasql-pool:=[profile?]
	dev-haskell/postgresql-libpq:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-db/postgresql:*
		dev-haskell/hspec:=[profile?]
		dev-haskell/quickcheck:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' hasql-notifications.cabal || die "sed failed"
}

src_test() {
	local db="${T}/pgsql"
	local POSTGRES_DB="hasql_notifications_test" POSTGRES_USER="postgres"

	initdb -U postgres -D "${db}" || die "initdb failed"
	pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'" \
		|| die "pg_ctl for start failed"
	createdb -h "${T}" -U postgres hasql_notifications_test \
		|| die "createdb failed"

	haskell-cabal_src_test

	pg_ctl -w -D "${db}" stop || die "pg_ctl for stop failed"
}

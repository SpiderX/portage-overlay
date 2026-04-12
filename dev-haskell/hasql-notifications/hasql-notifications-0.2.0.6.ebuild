# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
POSTGRES_COMPAT=( {14..18} )
POSTGRES_USEDEP="server"

inherit edo haskell-cabal postgres

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
	test? ( ${POSTGRES_DEP}
		dev-haskell/hspec
		dev-haskell/quickcheck )"

CABAL_CHDEPS=(
	'hasql-pool >= 0.4 && < 0.11' 'hasql-pool >= 0.4 && < 1.2'
)

pkg_setup() {
	haskell-cabal_pkg_setup
	postgres_pkg_setup
}

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' hasql-notifications.cabal || die "sed failed"
}

src_test() {
	local db="${T}/pgsql"
	local POSTGRES_DB="hasql_notifications_test" POSTGRES_USER="postgres"

	edo initdb -U postgres -D "${db}"
	edo pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'"
	edo createdb -h "${T}" -U postgres hasql_notifications_test

	haskell-cabal_src_test

	edo pg_ctl -w -D "${db}" stop
}

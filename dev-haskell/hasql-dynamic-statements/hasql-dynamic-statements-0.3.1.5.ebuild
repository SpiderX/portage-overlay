# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
POSTGRES_COMPAT=( {14..18} )
POSTGRES_USEDEP="server"

inherit edo haskell-cabal postgres

DESCRIPTION="Dynamic statements for Hasql"
HOMEPAGE="https://github.com/nikita-volkov/hasql-dynamic-statements"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/hasql:=[profile?]
	dev-haskell/hasql-implicits:=[profile?]
	dev-haskell/ptr:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( ${POSTGRES_DEP}
		dev-haskell/rerebase
		dev-haskell/tasty
		dev-haskell/tasty-hunit )"

pkg_setup() {
	haskell-cabal_pkg_setup
	postgres_pkg_setup
}

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' hasql-dynamic-statements.cabal \
		|| die "sed failed"
}

src_test() {
	local db="${T}/pgsql"
	local POSTGRES_DB="postgres" POSTGRES_USER="postgres" \
		POSTGRES_PASSWORD="postgres"

	edo initdb -U postgres -D "${db}"
	edo pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'"

	haskell-cabal_src_test

	edo pg_ctl -w -D "${db}" stop
}

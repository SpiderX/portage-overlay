# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

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
	test? ( dev-db/postgresql:*
		dev-haskell/rerebase:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-hunit:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	cabal-mksetup
	sed -i '/license-file/d' hasql-dynamic-statements.cabal \
		|| die "sed failed"
}

src_test() {
	local db="${T}/pgsql"
	local POSTGRES_DB="postgres" POSTGRES_USER="postgres" \
		POSTGRES_PASSWORD="postgres"

	initdb -U postgres -D "${db}" || die "initdb failed"
	pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'" \
		|| die "pg_ctl for start failed"

	haskell-cabal_src_test

	pg_ctl -w -D "${db}" stop || die "pg_ctl for stop failed"
}

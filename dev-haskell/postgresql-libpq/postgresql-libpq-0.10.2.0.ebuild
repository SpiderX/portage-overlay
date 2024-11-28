# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="low-level binding to libpq"
HOMEPAGE="https://github.com/haskellari/postgresql-libpq"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-db/postgresql:=
	dev-haskell/postgresql-libpq-configure
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-hunit:=[profile?] )"

CABAL_CHDEPS=(
	'tasty             ^>=1.5' 'tasty             ^>=1.4'
	'tasty-hunit       ^>=0.10.1' 'tasty-hunit       ^>=0.10.0'
)

src_prepare() {
	haskell-cabal_src_prepare
	cabal-mksetup
	sed -i '/license-file/d' postgresql-libpq.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure --flag=-use-pkg-config
}

src_test() {
	local db="${T}/pgsql"
	local DATABASE_CONNSTRING="postgresql://postgres@localhost/postgres"

	initdb -U postgres -D "${db}" || die "initdb failed"
	pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'" \
		|| die "pg_ctl for start failed"

	haskell-cabal_src_test

	pg_ctl -w -D "${db}" stop || die "pg_ctl for stop failed"
}

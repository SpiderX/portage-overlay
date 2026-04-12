# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
POSTGRES_COMPAT=( {14..18} )

inherit edo haskell-cabal postgres

DESCRIPTION="low-level binding to libpq"
HOMEPAGE="https://github.com/haskellari/postgresql-libpq"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="${POSTGRES_DEP}
	dev-haskell/postgresql-libpq-configure
	dev-haskell/postgresql-libpq-pkgconfig
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	virtual/pkgconfig
	test? ( <dev-db/postgresql-9999[server]
		dev-haskell/tasty
		dev-haskell/tasty-hunit )"

CABAL_CHDEPS=(
	'tasty             ^>=1.5' 'tasty             ^>=1.4'
	'tasty-hunit       ^>=0.10.1' 'tasty-hunit       ^>=0.10.0'
)

pkg_setup() {
	haskell-cabal_pkg_setup
	postgres_pkg_setup
}

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' postgresql-libpq.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure --flag=use-pkg-config
}

src_test() {
	local db="${T}/pgsql"
	local DATABASE_CONNSTRING="postgresql://postgres@localhost/postgres"

	edo initdb -U postgres -D "${db}"
	edo pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'"

	haskell-cabal_src_test

	edo pg_ctl -w -D "${db}" stop
}

# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
POSTGRES_COMPAT=( {14..18} )
POSTGRES_USEDEP="server"

inherit edo haskell-cabal postgres

DESCRIPTION="An efficient PostgreSQL driver with a flexible mapping API"
HOMEPAGE="https://github.com/nikita-volkov/hasql"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/attoparsec:=[profile?]
	dev-haskell/bytestring-strict-builder:=[profile?]
	dev-haskell/contravariant:=[profile?]
	dev-haskell/dlist:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/hashtables:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/network-ip:=[profile?]
	dev-haskell/postgresql-binary:=[profile?]
	dev-haskell/postgresql-libpq:=[profile?]
	dev-haskell/profunctors:=[profile?]
	dev-haskell/rerebase:=[profile?]
	dev-haskell/scientific:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/text-builder:=[profile?]
	dev-haskell/uuid:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( ${POSTGRES_DEP}
		dev-haskell/contravariant-extras
		dev-haskell/quickcheck-instances
		dev-haskell/rerebase
		dev-haskell/tasty
		dev-haskell/tasty-hunit
		dev-haskell/tasty-quickcheck )"

pkg_setup() {
	haskell-cabal_pkg_setup
	postgres_pkg_setup
}

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' hasql.cabal || die "sed failed"
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

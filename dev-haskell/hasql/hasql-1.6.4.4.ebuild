# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

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
	test? ( dev-db/postgresql:*
		dev-haskell/contravariant-extras:=[profile?]
		dev-haskell/quickcheck-instances:=[profile?]
		dev-haskell/rerebase:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-hunit:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	cabal-mksetup
	sed -i '/license-file/d' hasql.cabal || die "sed failed"
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

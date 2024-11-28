# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Encoders and decoders for the PostgreSQL's binary format"
HOMEPAGE="https://github.com/nikita-volkov/postgresql-binary"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/binary-parser:=[profile?]
	dev-haskell/bytestring-strict-builder:=[profile?]
	dev-haskell/network-ip:=[profile?]
	dev-haskell/scientific:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/uuid:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/postgresql-libpq:=[profile?]
		dev-haskell/quickcheck:=[profile?]
		dev-haskell/quickcheck-instances:=[profile?]
		dev-haskell/rerebase:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-hunit:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

CABAL_CHDEPS=(
	'rerebase >=1.20.1.1 && <2' 'rerebase >=1.18.1.1 && <2'
)

src_prepare() {
	haskell-cabal_src_prepare
	cabal-mksetup
	sed -i '/license-file/,+1d' postgresql-binary.cabal || die "sed failed"
}

src_test() {
	local db="${T}/pgsql"
	local POSTGRES_DB="postgres" POSTGRES_USER="postgres"

	initdb -U postgres -D "${db}" || die "initdb failed"
	pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'" \
		|| die "pg_ctl for start failed"

	haskell-cabal_src_test

	pg_ctl -w -D "${db}" stop || die "pg_ctl for stop failed"
}

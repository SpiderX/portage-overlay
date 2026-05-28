# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
POSTGRES_COMPAT=( {14..18} )

inherit haskell-cabal postgres

DESCRIPTION="Mid-Level PostgreSQL client library"
HOMEPAGE="https://github.com/haskellari/postgresql-libpq"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/attoparsec:=[profile?]
	dev-haskell/bytestring-builder:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/only:=[profile?]
	dev-haskell/postgresql-libpq:=[profile?]
	dev-haskell/scientific:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/time-compat:=[profile?]
	dev-haskell/uuid-types:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}
	${POSTGRES_DEP}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/base16-bytestring
		dev-haskell/cryptohash-md5
		dev-haskell/hunit
		dev-haskell/inspection-testing
		dev-haskell/tasty
		dev-haskell/tasty-golden
		dev-haskell/tasty-hunit )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' postgresql-simple.cabal || die "sed failed"
}

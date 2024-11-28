# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

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
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/base16-bytestring:=[profile?]
		dev-haskell/cryptohash-md5:=[profile?]
		dev-haskell/hunit:=[profile?]
		dev-haskell/inspection-testing:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-golden:=[profile?]
		dev-haskell/tasty-hunit:=[profile?] )"

CABAL_CHDEPS=(
	'postgresql-libpq    >=0.9.4.3    && <0.10' 'postgresql-libpq    >=0.9.4.3'
)

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' postgresql-simple.cabal || die "sed failed"
}

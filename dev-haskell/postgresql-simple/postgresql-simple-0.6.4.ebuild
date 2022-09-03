# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

HACKAGE_REV="8"

DESCRIPTION="Mid-Level PostgreSQL client library"
HOMEPAGE="https://github.com/haskellari/postgresql-libpq"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz
	https://hackage.haskell.org/package/${P}/revision/${HACKAGE_REV}.cabal -> ${PF}.cabal"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="test"

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
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/base16-bytestring
		dev-haskell/cryptohash-md5:=[profile?]
		dev-haskell/hunit:=[profile?]
		dev-haskell/inspection-testing:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-golden:=[profile?]
		dev-haskell/tasty-hunit:=[profile?] )"

src_prepare() {
	cp "${DISTDIR}/${PF}.cabal" "${S}/${PN}.cabal" || die "cp failed"

# Convert to unix line endings
#        dos2unix "${S}/${PN}.cabal" || die

	default
}

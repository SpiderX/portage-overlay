# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="An efficient PostgreSQL driver with a flexible mapping API"
HOMEPAGE="https://github.com/nikita-volkov/hasql"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND="dev-haskell/attoparsec:=[profile?]
	dev-haskell/bytestring-strict-builder:=[profile?]
	dev-haskell/contravariant:=[profile?]
	dev-haskell/dlist:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/hashtables:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/postgresql-binary:=[profile?]
	dev-haskell/postgresql-libpq:=[profile?]
	dev-haskell/profunctors:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/text-builder:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/contravariant-extras:=[profile?]
		dev-haskell/quickcheck:2=[profile?]
		dev-haskell/quickcheck-instances:=[profile?]
		dev-haskell/rerebase:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-hunit:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

src_prepare() {
	default

	cabal_chdeps \
		'postgresql-binary >=0.12.4 && <0.13' 'postgresql-binary >=0.12.3.3 && <0.13'

	sed -i '/license-file/d' hasql.cabal \
		|| die "sed failed"
}

# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="mid-level PostgreSQL client library"
HOMEPAGE="https://github.com/phadej/postgresql-simple"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test" # needs postgres

RDEPEND=">=dev-haskell/aeson-1.4.1.0:=[profile?]
	>=dev-haskell/attoparsec-0.13.2.3:=[profile?]
	>=dev-haskell/bytestring-builder-0.10.8.1.0:=[profile?]
	>=dev-haskell/case-insensitive-1.2.1.0:=[profile?]
	dev-haskell/fail:=[profile?]
	>=dev-haskell/hashable-1.2.7.0:=[profile?]
	>=dev-haskell/only-0.1:=[profile?]
	dev-haskell/postgresql-libpq:=[profile?]
	>=dev-haskell/scientific-0.3.6.2:=[profile?]
	>=dev-haskell/semigroups-0.18.5:=[profile?]
	>=dev-haskell/text-1.2.4.0:=[profile?]
	dev-haskell/uuid-types:=[profile?]
	>=dev-haskell/vector-0.12.1.2:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/base16-bytestring
		>=dev-haskell/cryptohash-md5-0.11
		dev-haskell/hunit
		dev-haskell/tasty
		dev-haskell/tasty-golden
		dev-haskell/tasty-hunit )"

src_prepare() {
	default

	cabal_chdeps \
		'base               >=4.6.0.0  && <4.13' 'base       >=4.6.0.0' \
		'template-haskell   >=2.8.0.0  && <2.15' 'template-haskell   >=2.8.0.0' \
		'time               >=1.4.0.1  && <1.9' 'time               >=1.4.0.1'
}

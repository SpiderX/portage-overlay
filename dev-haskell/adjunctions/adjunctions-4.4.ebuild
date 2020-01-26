# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Adjunctions and representable functors"
HOMEPAGE="https://github.com/ekmett/adjunctions"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/comonad-4:=[profile?]
	>=dev-haskell/contravariant-1:=[profile?]
	>=dev-haskell/distributive-0.5.1:=[profile?]
	dev-haskell/free:=[profile?]
	dev-haskell/mtl:=[profile?]
	>=dev-haskell/profunctors-4:=[profile?]
	>=dev-haskell/semigroupoids-4:=[profile?]
	>=dev-haskell/semigroups-0.11:=[profile?]
	>=dev-haskell/tagged-0.7:=[profile?]
	>=dev-haskell/transformers-compat-0.3:=[profile?]
	dev-haskell/void:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( >=dev-haskell/generic-deriving-1.11:=[profile?]
		>=dev-haskell/hspec-2:=[profile?] )"

src_prepare() {
	default

	cabal_chdeps \
		'containers          >= 0.3     && < 0.6' 'containers          >= 0.3'
}

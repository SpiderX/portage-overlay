# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Haskell 98 bifunctors, bifoldables and bitraversables"
HOMEPAGE="https://github.com/ekmett/bifunctors"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+semigroups +tagged"

RDEPEND=">=dev-haskell/base-orphans-0.5.2:=[profile?]
	>=dev-haskell/comonad-4:=[profile?]
	dev-haskell/th-abstraction:=[profile?]
	>=dev-haskell/transformers-compat-0.5:=[profile?]
	dev-lang/ghc:=
	semigroups? ( dev-haskell/semigroups:=[profile?] )
	tagged? ( >=dev-haskell/tagged-0.7.3:=[profile?] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( >=dev-haskell/hspec-1.8:=[profile?]
		dev-haskell/quickcheck:2=[profile?] )"

src_configure() {
	haskell-cabal_src_configure \
		"$(cabal_flag semigroups semigroups)" \
		"$(cabal_flag tagged tagged)"
}

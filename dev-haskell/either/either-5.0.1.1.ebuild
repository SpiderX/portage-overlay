# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="An either monad transformer"
HOMEPAGE="https://github.com/ekmett/either"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/bifunctors-4:=[profile?]
	dev-haskell/mtl:=[profile?]
	>=dev-haskell/profunctors-4:=[profile?]
	>=dev-haskell/semigroupoids-4:=[profile?]
	>=dev-haskell/semigroups-0.8.3.1:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( >=dev-haskell/quickcheck-2.9:2=[profile?]
		>=dev-haskell/test-framework-0.8.1.1:=[profile?]
		>=dev-haskell/test-framework-quickcheck2-0.3.0.3:=[profile?] )"

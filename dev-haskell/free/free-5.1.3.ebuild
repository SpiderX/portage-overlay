# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Monads for free"
HOMEPAGE="https://github.com/ekmett/free"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/bifunctors-4:=[profile?]
	>=dev-haskell/comonad-4:=[profile?]
	dev-haskell/distributive:=[profile?]
	>=dev-haskell/exceptions-0.6:=[profile?]
	dev-haskell/fail:=[profile?]
	dev-haskell/mtl:=[profile?]
	>=dev-haskell/profunctors-4:=[profile?]
	>=dev-haskell/semigroupoids-4:=[profile?]
	>=dev-haskell/semigroups-0.8.3.1:=[profile?]
	>=dev-haskell/transformers-base-0.4:=[profile?]
	>=dev-haskell/transformers-compat-0.5.1.0:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"

# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Kan extensions"
HOMEPAGE="https://github.com/ekmett/kan-extensions"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/adjunctions:=[profile?]
	>=dev-haskell/comonad-4:=[profile?]
	>=dev-haskell/contravariant-1:=[profile?]
	dev-haskell/distributive:=[profile?]
	dev-haskell/fail:=[profile?]
	dev-haskell/free:=[profile?]
	dev-haskell/invariant:=[profile?]
	dev-haskell/mtl:=[profile?]
	>=dev-haskell/profunctors-5:=[profile?]
	>=dev-haskell/semigroupoids-4:=[profile?]
	>=dev-haskell/tagged-0.7.2:=[profile?]
	>=dev-haskell/transformers-compat-0.3:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"

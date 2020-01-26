# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Haskell 98 invariant functors"
HOMEPAGE="https://github.com/nfrisby/invariant-functors"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/bifunctors-5.2:=[profile?]
	>=dev-haskell/comonad-5:=[profile?]
	>=dev-haskell/contravariant-0.5:=[profile?]
	>=dev-haskell/profunctors-5.2.1:=[profile?]
	>=dev-haskell/semigroups-0.16.2:=[profile?]
	>=dev-haskell/statevar-1.1:=[profile?]
	dev-haskell/stm:=[profile?]
	>=dev-haskell/tagged-0.7.3:=[profile?]
	dev-haskell/th-abstraction:=[profile?]
	>=dev-haskell/transformers-compat-0.3:=[profile?]
	>=dev-haskell/unordered-containers-0.2.4:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( >=dev-haskell/hspec-1.8:=[profile?]
		>=dev-haskell/quickcheck-2.11:2=[profile?] )"

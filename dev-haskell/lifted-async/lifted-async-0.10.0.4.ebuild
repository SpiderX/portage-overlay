# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Run lifted IO operations asynchronously and wait for their results"
HOMEPAGE="https://github.com/maoe/lifted-async"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/async-2.2:=[profile?]
	dev-haskell/constraints:=[profile?]
	dev-haskell/lifted-base:=[profile?]
	>=dev-haskell/monad-control-1.0:=[profile?]
	>=dev-haskell/transformers-base-0.4:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/hunit:=[profile?]
		dev-haskell/mtl:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-expected-failure:=[profile?]
		>=dev-haskell/tasty-hunit-0.9:=[profile?]
		dev-haskell/tasty-th:=[profile?] )"

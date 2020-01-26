# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Hedgehog will eat all your bugs"
HOMEPAGE="https://hedgehog.qa"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/ansi-terminal:=[profile?]
	dev-haskell/async:=[profile?]
	dev-haskell/concurrent-output:=[profile?]
	dev-haskell/erf:=[profile?]
	>=dev-haskell/exceptions-0.7:=[profile?]
	dev-haskell/fail:=[profile?]
	>=dev-haskell/lifted-async-0.7:=[profile?]
	dev-haskell/mmorph:=[profile?]
	>=dev-haskell/monad-control-1.0:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/pretty-show:=[profile?]
	>=dev-haskell/primitive-0.6:=[profile?]
	>=dev-haskell/random-1.1:=[profile?]
	>=dev-haskell/resourcet-1.1:=[profile?]
	>=dev-haskell/semigroups-0.16:=[profile?]
	dev-haskell/stm:=[profile?]
	>=dev-haskell/text-1.1:=[profile?]
	>=dev-haskell/transformers-base-0.4.5.1:=[profile?]
	dev-haskell/wl-pprint-annotated:=[profile?]
	>=dev-lang/ghc-8.0.1:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"

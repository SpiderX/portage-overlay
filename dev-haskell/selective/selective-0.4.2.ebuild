# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Selective applicative functors"
HOMEPAGE="https://github.com/snowleopard/selective"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/mtl:=[profile?]
		dev-haskell/quickcheck:2=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-expected-failure:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

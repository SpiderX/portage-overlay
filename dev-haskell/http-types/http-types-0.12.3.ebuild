# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Generic HTTP types for Haskell (for both client and server code)"
HOMEPAGE="https://github.com/aristidb/http-types"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/case-insensitive:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/doctest:=[profile?]
		dev-haskell/hspec:=[profile?]
		dev-haskell/quickcheck:2=[profile?]
		dev-haskell/quickcheck-instances:=[profile?] )"

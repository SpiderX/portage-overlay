# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Cross-Origin resource sharing (CORS) for Wai"
HOMEPAGE="https://github.com/larskuhtz/wai-cors"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test" # test requires PhantomJS

RDEPEND="dev-haskell/attoparsec:=[profile?]
	dev-haskell/base-unicode-symbols:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/http-types:=[profile?]
	>=dev-haskell/mtl-2.2:=[profile?]
	>=dev-haskell/transformers-0.4:=[profile?]
	>=dev-haskell/wai-3.0:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( >=dev-haskell/network-2.6:=[profile?]
		>=dev-haskell/tasty-0.11:=[profile?]
		dev-haskell/tasty-hunit:=[profile?]
		>=dev-haskell/text-1.2:=[profile?]
		dev-haskell/wai-extra:=[profile?]
		dev-haskell/wai-websockets:=[profile?]
		dev-haskell/warp:=[profile?]
		dev-haskell/websockets:=[profile?] )"

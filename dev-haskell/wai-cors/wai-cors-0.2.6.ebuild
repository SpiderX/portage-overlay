# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Cross-Origin resource sharing (CORS) for Wai"
HOMEPAGE="https://github.com/larskuhtz/wai-cors"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/attoparsec:=[profile?]
	dev-haskell/base-unicode-symbols:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/resourcet:=[profile?]
	dev-haskell/transformers:=[profile?]
	dev-haskell/transformers-compat:=[profile?]
	dev-haskell/wai:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}
	dev-haskell/cabal:="

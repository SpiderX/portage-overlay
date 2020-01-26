# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Render tasty output to XML for Jenkins"
HOMEPAGE="https://github.com/ocharles/tasty-ant-xml"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/generic-deriving:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/stm:=[profile?]
	>=dev-haskell/tagged-0.7:=[profile?]
	>=dev-haskell/tasty-0.10:=[profile?]
	dev-haskell/xml:=[profile?]
	>=dev-lang/ghc-8.0.1:="
DEPEND="${RDEPEND}"
BDEPEND=">=dev-haskell/cabal-1.24.0.0:=[profile?]"

# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="A logging system for WAI"
HOMEPAGE="http://hackage.haskell.org/package/wai-logger"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/byteorder:=[profile?]
	>=dev-haskell/fast-logger-3:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/network:=[profile?]
	>=dev-haskell/wai-2.0.0:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( >=dev-haskell/doctest-0.10.1:=[profile?] )"

# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Experimental Hspec support for testing WAI applications"
HOMEPAGE="https://github.com/hspec/hspec-wai"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/base-compat:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/hspec-core:=[profile?]
	>=dev-haskell/hspec-expectations-0.8.0:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/quickcheck:2=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-haskell/wai-3:=[profile?]
	>=dev-haskell/wai-extra-3:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/hspec:=[profile?] )"

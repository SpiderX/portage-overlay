# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Utility functions for testing Megaparsec parsers with Hspec"
HOMEPAGE="https://github.com/mrkkrp/hspec-megaparsec"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="dev"

RDEPEND="dev-haskell/hspec-expectations:=[profile?]
	dev-haskell/megaparsec:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/hspec:= )"

src_configure() {
	haskell-cabal_src_configure "$(cabal_flag dev dev)"
}

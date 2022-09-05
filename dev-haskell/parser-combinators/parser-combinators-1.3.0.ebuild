# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Lightweight package providing commonly useful parser combinators"
HOMEPAGE="https://github.com/mrkkrp/parser-combinators"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="dev test"
RESTRICT="test" # no tests

RDEPEND="dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/hspec:=[profile?]
		dev-haskell/hspec-expectations:=[profile?]
		dev-haskell/hspec-megaparsec:=[profile?]
		dev-haskell/megaparsec:=[profile?]
		dev-haskell/megaparsec-tests:=[profile?]
		dev-haskell/quickcheck:=[profile?] )"

src_configure() {
	haskell-cabal_src_configure "$(cabal_flag dev dev)"
}

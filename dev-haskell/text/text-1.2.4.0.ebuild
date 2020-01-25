# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour nocabaldep test-suite"

inherit haskell-cabal

DESCRIPTION="An efficient packed Unicode text type"
HOMEPAGE="https://github.com/haskell/text"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/hunit:=[profile?]
		>=dev-haskell/quickcheck-2.7:2=[profile?]
		>=dev-haskell/quickcheck-unicode-1.0.1:=[profile?]
		dev-haskell/random:=[profile?]
		dev-haskell/test-framework:=[profile?]
		dev-haskell/test-framework-hunit:=[profile?]
		dev-haskell/test-framework-quickcheck2:=[profile?] )"

src_prepare() {
	default

	cabal_chdeps \
		'QuickCheck >= 2.7 && < 2.11' 'QuickCheck >= 2.7'
}

src_configure() {
	haskell-cabal_src_configure \
		--flag=-bytestring-builder \
		--flag=-developer \
		--flag=-integer-simple
}

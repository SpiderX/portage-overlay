# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=2
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
CABAL_PN="${PN^}"

inherit haskell-cabal

DESCRIPTION="Ranged sets for Haskell"
HOMEPAGE="https://github.com/PaulJohnson/Ranged-sets"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/hunit:=[profile?]
	dev-haskell/quickcheck:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' Ranged-sets.cabal || die "sed failed"
}

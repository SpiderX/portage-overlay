# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=1
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
CABAL_PN="ChasingBottoms"

inherit haskell-cabal

DESCRIPTION="For testing partial and infinite values"
HOMEPAGE="https://hackage.haskell.org/package/ChasingBottoms"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/quickcheck:=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/syb:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' ChasingBottoms.cabal || die "sed failed"
}

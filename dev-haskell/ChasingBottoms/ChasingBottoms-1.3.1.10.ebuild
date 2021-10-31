# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="For testing partial and infinite values"
HOMEPAGE="https://hackage.haskell.org/package/ChasingBottoms"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/mtl:=[profile?]
	dev-haskell/quickcheck:2=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/syb:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	default

	sed -i '/license-file/d' ChasingBottoms.cabal \
		|| die "sed failed"
}

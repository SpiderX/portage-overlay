# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"
CABAL_PN="MonadRandom"

inherit haskell-cabal

DESCRIPTION="Random-number generation monad"
HOMEPAGE="https://github.com/byorgey/MonadRandom"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/primitive:=[profile?]
	dev-haskell/random:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' MonadRandom.cabal || die "sed failed"
}

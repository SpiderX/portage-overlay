# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Stochastic streaming algorithms for approximate computation"
HOMEPAGE="https://github.com/iand675/datasketches-haskell"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/data-sketches-core:=[profile?]
	dev-haskell/mwc-random:=[profile?]
	dev-haskell/primitive:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-haskell/vector-algorithms:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec
		dev-haskell/hspec-discover
		dev-haskell/pretty-show
		dev-haskell/quickcheck
		dev-haskell/statistics )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/License-File/d' data-sketches.cabal || die "sed failed"
}

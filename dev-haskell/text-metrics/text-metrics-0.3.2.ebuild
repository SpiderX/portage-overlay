# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=4
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Calculate various string metrics efficiently in Haskell"
HOMEPAGE="https://github.com/mrkkrp/text-metrics"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/text:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec:=
		dev-haskell/quickcheck:= )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' text-metrics.cabal || die "sed failed"
}

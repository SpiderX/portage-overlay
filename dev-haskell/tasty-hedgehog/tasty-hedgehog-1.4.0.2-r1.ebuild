# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=8
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Integration for tasty and hedgehog"
HOMEPAGE="https://github.com/qfpl/tasty-hedgehog"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/hedgehog:=[profile?]
	dev-haskell/tagged:=[profile?]
	dev-haskell/tasty:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/tasty-expected-failure )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/,+1d' tasty-hedgehog.cabal || die "sed failed"
}

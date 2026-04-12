# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Efficient strict text builder"
HOMEPAGE="https://github.com/nikita-volkov/text-builder"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/text:=[profile?]
	dev-haskell/text-builder-dev:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/quickcheck
		dev-haskell/quickcheck-instances
		dev-haskell/rerebase
		dev-haskell/tasty
		dev-haskell/tasty-hunit
		dev-haskell/tasty-quickcheck )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' text-builder.cabal || die "sed failed"
}

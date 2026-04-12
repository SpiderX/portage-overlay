# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Extras for the primitive library"
HOMEPAGE="https://github.com/nikita-volkov/primitive-extras"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/cereal:=[profile?]
	dev-haskell/deferred-folds:=[profile?]
	dev-haskell/focus:=[profile?]
	dev-haskell/foldl:=[profile?]
	dev-haskell/list-t:=[profile?]
	dev-haskell/primitive:=[profile?]
	dev-haskell/profunctors:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-haskell/primitive-unlifted:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/quickcheck
		dev-haskell/rerebase
		dev-haskell/tasty
		dev-haskell/tasty-hunit
		dev-haskell/tasty-quickcheck )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' primitive-extras.cabal || die "sed failed"
}

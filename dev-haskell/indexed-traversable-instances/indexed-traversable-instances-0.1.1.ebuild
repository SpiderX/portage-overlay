# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="More instances of FunctorWithIndex, FoldableWithIndex"
HOMEPAGE="https://github.com/haskellari/indexed-traversable"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # need quickcheck-2.14.2, quickcheck-instances-0.3.26

RDEPEND="dev-haskell/indexed-traversable:=[profile?]
	dev-haskell/OneTuple:=[profile?]
	dev-haskell/tagged:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/quickcheck:2=[profile?]
		dev-haskell/quickcheck-instances:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?]
		dev-haskell/transformers:=[profile?] )"

src_prepare() {
	default

	sed -i '/license-file/d' indexed-traversable-instances.cabal \
		|| die "sed failed"
}

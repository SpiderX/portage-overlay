# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Abstractions over deferred folds"
HOMEPAGE="https://github.com/nikita-volkov/deferred-folds"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/foldl:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/primitive:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/quickcheck-instances
		dev-haskell/rerebase
		dev-haskell/tasty
		dev-haskell/tasty-quickcheck )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' deferred-folds.cabal || die "sed failed"
}

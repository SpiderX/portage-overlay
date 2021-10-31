# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Abstractions over deferred folds"
HOMEPAGE="https://github.com/metrix-ai/deferred-folds"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

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
	test? ( dev-haskell/quickcheck:2=[profile?]
		dev-haskell/quickcheck-instances:=[profile?]
		dev-haskell/rerebase:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-hunit:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

src_prepare() {
	default

	sed -i '/license-file/d' deferred-folds.cabal \
		|| die "sed failed"
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Associative containers retating insertion order for traversals"
HOMEPAGE="https://github.com/phadej/insert-ordered-containers"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/indexed-traversable:=[profile?]
	dev-haskell/lens:=[profile?]
	dev-haskell/optics-core:=[profile?]
	dev-haskell/optics-extra:=[profile?]
	dev-haskell/semigroupoids:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/base-compat:=[profile?]
		dev-haskell/quickcheck:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' insert-ordered-containers.cabal \
		|| die "sed failed"
}

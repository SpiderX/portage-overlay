# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Associative containers retating insertion order for traversals"
HOMEPAGE="https://github.com/phadej/insert-ordered-containers"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/base-compat:=[profile?]
	dev-haskell/hashable:=[profile?]
	>=dev-haskell/indexed-traversable-0.1.1:=[profile?]
	dev-haskell/lens:=[profile?]
	dev-haskell/optics-core:=[profile?]
	dev-haskell/optics-extra:=[profile?]
	dev-haskell/semigroupoids:=[profile?]
	dev-haskell/semigroups:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-haskell/unordered-containers-0.2.14.0:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/quickcheck:2=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

src_prepare() {
	default

	sed -i '/license-file/d' insert-ordered-containers.cabal \
		|| die "sed failed"
}

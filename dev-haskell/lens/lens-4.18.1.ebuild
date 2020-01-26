# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Lenses, Folds and Traversals"
HOMEPAGE="https://github.com/ekmett/lens"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="benchmark-uniplate dump-splices +inlining j old-inline-pragmas safe +test-doctests +test-templates +trustworthy"
RESTRICT="test"

RDEPEND=">=dev-haskell/base-orphans-0.5.2:=[profile?]
	>=dev-haskell/bifunctors-5.1:=[profile?]
	dev-haskell/call-stack:=[profile?]
	>=dev-haskell/comonad-4:=[profile?]
	>=dev-haskell/contravariant-1.3:=[profile?]
	dev-haskell/distributive:=[profile?]
	dev-haskell/exceptions:=[profile?]
	dev-haskell/free:=[profile?]
	>=dev-haskell/generic-deriving-1.10:=[profile?]
	dev-haskell/hashable:=[profile?]
	>=dev-haskell/kan-extensions-5:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/nats:=[profile?]
	dev-haskell/parallel:=[profile?]
	>=dev-haskell/profunctors-5.2.1:=[profile?]
	>=dev-haskell/reflection-2.1:=[profile?]
	>=dev-haskell/semigroupoids-5:=[profile?]
	dev-haskell/semigroups:=[profile?]
	dev-haskell/tagged:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/th-abstraction:=[profile?]
	>=dev-haskell/transformers-compat-0.4:=[profile?]
	dev-haskell/type-equality:=[profile?]
	>=dev-haskell/unordered-containers-0.2.4:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-haskell/void:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	dev-haskell/cabal-doctest:=[profile?]
	test? ( dev-haskell/hunit:=[profile?]
		dev-haskell/quickcheck:2=[profile?]
		dev-haskell/test-framework:=[profile?]
		dev-haskell/test-framework-hunit:=[profile?]
		dev-haskell/test-framework-quickcheck2:=[profile?]
		dev-haskell/test-framework-th:=[profile?]
		test-doctests? ( dev-haskell/simple-reflect:=[profile?] ) )"

src_configure() {
	haskell-cabal_src_configure --flag=-lib-werror --flag=test-hunit \
		--flag=test-properties \
		"$(cabal_flag benchmark-uniplate benchmark-uniplate)" \
		"$(cabal_flag dump-splices dump-splices)" \
		"$(cabal_flag inlining inlining)" \
		"$(cabal_flag j j)" \
		"$(cabal_flag old-inline-pragmas old-inline-pragmas)" \
		"$(cabal_flag safe safe)" \
		"$(cabal_flag test-doctests test-doctests)" \
		"$(cabal_flag test-templates test-templates)" \
		"$(cabal_flag trustworthy trustworthy)"
}

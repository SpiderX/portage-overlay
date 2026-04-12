# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Swagger 2.0 data model"
HOMEPAGE="https://github.com/GetShopTV/swagger2"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/aeson-pretty:=[profile?]
	dev-haskell/base-compat-batteries:=[profile?]
	dev-haskell/cookie:=[profile?]
	dev-haskell/generics-sop:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/http-media:=[profile?]
	dev-haskell/insert-ordered-containers:=[profile?]
	dev-haskell/lens:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/optics-core:=[profile?]
	dev-haskell/optics-th:=[profile?]
	dev-haskell/quickcheck:=[profile?]
	dev-haskell/scientific:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/uuid-types:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	dev-haskell/cabal-doctest:=
	test? ( dev-haskell/doctest
		dev-haskell/glob
		dev-haskell/hspec
		dev-haskell/hunit
		dev-haskell/quickcheck-instances
		dev-haskell/utf8-string )"

src_prepare() {
	haskell-cabal_src_prepare
	# disable failed doctest
	sed -i  -e '/license-file/d' \
		-e '/test-suite doctests/,+10d' \
		swagger2.cabal || die "sed failed"
}

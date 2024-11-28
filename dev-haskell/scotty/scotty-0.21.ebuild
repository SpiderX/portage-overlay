# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=2
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Haskell web framework"
HOMEPAGE="https://github.com/scotty-web/scotty"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/blaze-builder:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/cookie:=[profile?]
	dev-haskell/data-default-class:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/monad-control:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/regex-compat:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/transformers-base:=[profile?]
	dev-haskell/transformers-compat:=[profile?]
	dev-haskell/unliftio:=[profile?]
	dev-haskell/wai:=[profile?]
	dev-haskell/wai-extra:=[profile?]
	dev-haskell/warp:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/async:=[profile?]
		dev-haskell/doctest:=[profile?]
		dev-haskell/hspec:=[profile?]
		dev-haskell/hspec-wai:=[profile?]
		dev-haskell/http-client:=[profile?]
		dev-haskell/lifted-base:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' scotty.cabal || die "sed failed"
}

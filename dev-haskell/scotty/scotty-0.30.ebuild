# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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
	dev-haskell/http-api-data:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/monad-control:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/regex-compat:=[profile?]
	dev-haskell/resourcet:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/transformers-base:=[profile?]
	dev-haskell/unliftio:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/wai:=[profile?]
	dev-haskell/wai-extra:=[profile?]
	dev-haskell/warp:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/async
		dev-haskell/doctest
		dev-haskell/hspec
		dev-haskell/hspec-wai
		dev-haskell/http-client
		dev-haskell/lifted-base )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' scotty.cabal || die "sed failed"
}

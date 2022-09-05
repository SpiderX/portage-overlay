# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_HACKAGE_REVISION=1
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Easy-to-use, type-safe, expandable, high-level HTTP client library"
HOMEPAGE="https://github.com/mrkkrp/req"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="dev test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/authenticate-oauth:=[profile?]
	dev-haskell/blaze-builder:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/connection:=[profile?]
	dev-haskell/exceptions:=[profile?]
	dev-haskell/http-api-data:=[profile?]
	>=dev-haskell/http-client-0.7:=[profile?]
	dev-haskell/http-client-tls:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/modern-uri:=[profile?]
	dev-haskell/monad-control:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/retry:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/transformers-base:=[profile?]
	dev-haskell/unliftio-core:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/hspec:=
		dev-haskell/hspec-core:=
		dev-haskell/quickcheck:=
		dev-haskell/unordered-containers:= )"

src_configure() {
	haskell-cabal_src_configure "$(cabal_flag dev dev)"
}

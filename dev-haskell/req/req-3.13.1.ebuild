# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=1
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Easy-to-use, type-safe, expandable, high-level HTTP client library"
HOMEPAGE="https://github.com/mrkkrp/req"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="dev"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/authenticate-oauth:=[profile?]
	dev-haskell/blaze-builder:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/crypton-connection:=[profile?]
	dev-haskell/http-api-data:=[profile?]
	dev-haskell/http-client:=[profile?]
	dev-haskell/http-client-tls:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/modern-uri:=[profile?]
	dev-haskell/monad-control:=[profile?]
	dev-haskell/retry:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/transformers-base:=[profile?]
	dev-haskell/unliftio-core:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/hspec:=
		dev-haskell/hspec-core:=
		dev-haskell/quickcheck:= )"

PATCHES=( "${FILESDIR}/${PN}"-3.13.1-tests.patch
	"${FILESDIR}/${PN}"-3.13.1-test.patch
	"${FILESDIR}/${PN}"-3.13.1-test-httpbin.patch )

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' req.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure "$(cabal_flag dev dev)"
}

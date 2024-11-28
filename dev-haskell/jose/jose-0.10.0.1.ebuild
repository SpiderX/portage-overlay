# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Haskell JOSE and JWT library"
HOMEPAGE="https://github.com/frasertweedale/hs-jose"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/aeson:=[profile?]
	>=dev-haskell/base64-bytestring-1.2.1.0:=[profile?]
	dev-haskell/concise:=[profile?]
	dev-haskell/cryptonite:=[profile?]
	dev-haskell/lens:=[profile?]
	dev-haskell/memory:=[profile?]
	dev-haskell/monad-time:=[profile?]
	dev-haskell/network-uri:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/x509:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hedgehog:=[profile?]
		dev-haskell/hspec:=[profile?]
		dev-haskell/pem:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-hedgehog:=[profile?]
		dev-haskell/tasty-hspec:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' jose.cabal || die "sed failed"
}

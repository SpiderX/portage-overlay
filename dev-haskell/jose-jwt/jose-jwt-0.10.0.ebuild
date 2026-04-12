# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="JSON Object Signing and Encryption Library"
HOMEPAGE="https://github.com/tekul/jose-jwt"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/attoparsec:=[profile?]
	dev-haskell/cereal:=[profile?]
	dev-haskell/crypton:=[profile?]
	dev-haskell/memory:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/transformers-compat:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec
		dev-haskell/hunit
		dev-haskell/quickcheck )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' jose-jwt.cabal || die "sed failed"
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
CABAL_PN="${PN^^}"

inherit haskell-cabal

DESCRIPTION="Deterministic random bit generator (aka PRNG)"
HOMEPAGE="https://github.com/TomMD/DRBG"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # https://github.com/TomMD/DRBG/issues/7

RDEPEND="dev-haskell/cereal:=[profile?]
	dev-haskell/cipher-aes128:=[profile?]
	dev-haskell/crypto-api:=[profile?]
	dev-haskell/cryptohash-cryptoapi:=[profile?]
	dev-haskell/entropy:=[profile?]
	dev-haskell/parallel:=[profile?]
	dev-haskell/prettyclass:=[profile?]
	dev-haskell/tagged:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/crypto-api-tests:=[profile?]
		dev-haskell/hunit:=[profile?]
		dev-haskell/quickcheck:=[profile?]
		dev-haskell/test-framework:=[profile?]
		dev-haskell/test-framework-hunit:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' DRBG.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure "$(cabal_flag test test)"
}

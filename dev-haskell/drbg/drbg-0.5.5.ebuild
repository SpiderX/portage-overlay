# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

MY_PN="${PN^^}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Deterministic random bit generator (aka PRNG)"
HOMEPAGE="https://github.com/TomMD/DRBG"
SRC_URI="https://hackage.haskell.org/package/${MY_P}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # fails

RDEPEND="dev-haskell/cereal:=[profile?]
	dev-haskell/cipher-aes128:=[profile?]
	dev-haskell/crypto-api:=[profile?]
	dev-haskell/cryptohash-cryptoapi:=[profile?]
	dev-haskell/entropy:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/parallel:=[profile?]
	dev-haskell/prettyclass:=[profile?]
	dev-haskell/tagged:=[profile?]
	dev-haskell/sha:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/crypto-api-tests:=[profile?]
		dev-haskell/hunit:=[profile?]
		dev-haskell/quickcheck:2=[profile?]
		dev-haskell/test-framework:=[profile?]
		dev-haskell/test-framework-hunit:=[profile?] )"

S="${WORKDIR}/${MY_P}"

src_configure() {
	haskell-cabal_src_configure "$(cabal_flag test test)"
}

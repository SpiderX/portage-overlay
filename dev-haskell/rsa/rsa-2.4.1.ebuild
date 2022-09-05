# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

MY_PN="${PN^^}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Implementation of RSA, using the padding schemes of PKCS#1 v2.1"
HOMEPAGE="https://github.com/GaloisInc/RSA"
SRC_URI="https://hackage.haskell.org/package/${MY_P}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/crypto-api:=[profile?]
	dev-haskell/crypto-pubkey-types:=[profile?]
	dev-haskell/sha:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/crypto-pubkey-types:=[profile?]
		dev-haskell/drbg:=[profile?]
		dev-haskell/quickcheck:2=[profile?]
		dev-haskell/tagged:=[profile?]
		dev-haskell/test-framework:=[profile?]
		dev-haskell/test-framework-quickcheck2:=[profile?] )"

S="${WORKDIR}/${MY_P}"

src_configure() {
	haskell-cabal_src_configure \
		--flag=-buildtestexecutable \
		--flag=-oldbase
}

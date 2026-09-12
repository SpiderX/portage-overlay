# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=2
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
CABAL_PN="${PN^^}"

inherit haskell-cabal

DESCRIPTION="Implementation of RSA, using the padding schemes of PKCS#1 v2.1"
HOMEPAGE="https://github.com/GaloisInc/RSA"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/crypto-api:=[profile?]
	dev-haskell/crypto-pubkey-types:=[profile?]
	dev-haskell/sha:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/crypto-pubkey-types
		dev-haskell/quickcheck
		dev-haskell/tagged
		dev-haskell/test-framework
		dev-haskell/test-framework-quickcheck2 )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/,+1d' RSA.cabal || die "sed failed"
}

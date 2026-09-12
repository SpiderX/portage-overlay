# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Crypto-api interfaces for cryptohash"
HOMEPAGE="https://github.com/vincenthz/hs-cryptohash-cryptoapi"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/cereal:=[profile?]
	dev-haskell/crypto-api:=[profile?]
	dev-haskell/cryptonite:=[profile?]
	dev-haskell/memory:=[profile?]
	dev-haskell/tagged:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/License-file/d' cryptohash-cryptoapi.cabal || die "sed failed"
}

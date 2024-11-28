# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Generic cryptography Public keys algorithm types"
HOMEPAGE="https://github.com/vincenthz/hs-crypto-pubkey-types"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/asn1-encoding:=[profile?]
	dev-haskell/asn1-types:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/License-file/d' crypto-pubkey-types.cabal || die "sed failed"
}

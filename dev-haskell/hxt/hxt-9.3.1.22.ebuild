# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="A collection of tools for processing XML with Haskell"
HOMEPAGE="https://github.com/UweSchmidt/hxt"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+network-uri profile"

RDEPEND="dev-haskell/hxt-charproperties:=[profile?]
	dev-haskell/hxt-regex-xmlschema:=[profile?]
	dev-haskell/hxt-unicode:=[profile?]
	dev-haskell/network-uri:=[profile?]
	dev-haskell/parsec:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' hxt.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure \
		"$(cabal_flag network-uri network-uri)" \
		"$(cabal_flag profile profile)"
}

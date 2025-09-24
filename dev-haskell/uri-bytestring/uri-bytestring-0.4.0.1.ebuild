# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Haskell URI parsing as ByteStrings"
HOMEPAGE="https://github.com/Soostone/uri-bytestring"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-haskell/attoparsec:=[profile?]
	dev-haskell/blaze-builder:=[profile?]
	dev-haskell/th-lift-instances:=[profile?]
	dev-lang/ghc:="
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/base-compat:=[profile?]
		dev-haskell/hedgehog:=[profile?]
		dev-haskell/hunit:=[profile?]
		dev-haskell/safe:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-hedgehog:=[profile?]
		dev-haskell/tasty-hunit:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/,+1d' uri-bytestring.cabal || die "sed failed"
}

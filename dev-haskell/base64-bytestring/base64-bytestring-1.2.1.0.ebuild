# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Fast base64 encoding and decoding for Haskell"
HOMEPAGE="https://github.com/haskell/base64-bytestring"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hunit:=[profile?]
		dev-haskell/quickcheck:2=[profile?]
		dev-haskell/test-framework:=[profile?]
		dev-haskell/test-framework-hunit:=[profile?]
		dev-haskell/test-framework-quickcheck2:=[profile?] )"

src_prepare() {
	default

	sed -i '/license-file/d' base64-bytestring.cabal \
		|| die "sed failed"
}

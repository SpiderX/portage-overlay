# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="HTTP/2.0 library including frames and HPACK"
HOMEPAGE="https://github.com/kazu-yamamoto/http2"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/case-insensitive:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/network-byte-order:=[profile?]
	dev-haskell/psqueues:=[profile?]
	dev-haskell/stm:=[profile?]
	dev-haskell/time-manager:=[profile?]
	>=dev-lang/ghc-7.10.1:="
DEPEND="${RDEPEND}"
BDEPEND=">=dev-haskell/cabal-1.22.2.0:=[profile?]
	test? ( dev-haskell/aeson:=[profile?]
		dev-haskell/aeson-pretty:=[profile?]
		dev-haskell/base16-bytestring:=[profile?]
		dev-haskell/doctest:=[profile?]
		>=dev-haskell/glob-0.9:=[profile?]
		dev-haskell/hspec:=[profile?]
		dev-haskell/text:=[profile?]
		dev-haskell/unordered-containers:=[profile?]
		dev-haskell/vector:=[profile?]
		dev-haskell/word8:=[profile?] )"

src_configure() {
	haskell-cabal_src_configure --flag=-devel
}

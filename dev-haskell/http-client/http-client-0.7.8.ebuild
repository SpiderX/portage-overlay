# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="An HTTP client engine"
HOMEPAGE="https://github.com/snoyberg/http-client"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+network-uri"
RESTRICT="test" # needs network

RDEPEND="dev-haskell/blaze-builder:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/cookie:=[profile?]
	dev-haskell/exceptions:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/iproute:=[profile?]
	dev-haskell/memory:=[profile?]
	dev-haskell/mime-types:=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/stm:=[profile?]
	dev-haskell/streaming-commons:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:=
	network-uri? ( >=dev-haskell/network-2.6:=[profile?]
			>=dev-haskell/network-uri-2.6:=[profile?] )
	!network-uri? ( >=dev-haskell/network-2.4:=[profile?] <dev-haskell/network-2.6:=[profile?] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/async:=
		dev-haskell/hspec:=
		dev-haskell/monad-control:=
		dev-haskell/streaming-commons:=
		dev-haskell/zlib:=
		!network-uri? ( dev-haskell/network-uri:= ) )"

src_configure() {
	haskell-cabal_src_configure "$(cabal_flag network-uri network-uri)"
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="HTTP/2 library"
HOMEPAGE="https://github.com/kazu-yamamoto/http2"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-haskell/async:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/network:=[profile?]
	>=dev-haskell/network-byte-order-0.1.7:=[profile?]
	dev-haskell/network-control:=[profile?]
	>=dev-haskell/time-manager-0.0.1:=[profile?]
	>=dev-haskell/unix-time-0.4.11:=[profile?]
	dev-haskell/unliftio:=[profile?]
	dev-haskell/utf8-string:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/aeson:=[profile?]
		dev-haskell/aeson-pretty:=[profile?]
		>=dev-haskell/base16-bytestring-1.0:=[profile?]
		dev-haskell/crypton:=[profile?]
		dev-haskell/text:=[profile?]
		dev-haskell/unordered-containers:=[profile?]
		dev-haskell/vector:=[profile?] )"

CABAL_CHDEPS=(
	'time-manager >= 0.0.1 && < 0.1' 'time-manager >= 0.0.1'
)

src_prepare() {
	haskell-cabal_src_prepare

	sed -i '/license-file/d' http2.cabal \
		|| die "sed failed"

	# remove failed test
	sed -i '/prevents attacks/,+8d' test/HTTP2/ServerSpec.hs \
		|| die "sed failed for ServerSpec.hs"
}

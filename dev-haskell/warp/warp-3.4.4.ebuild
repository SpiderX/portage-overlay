# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="A fast, light-weight web server for WAI applications"
HOMEPAGE="https://github.com/yesodweb/wai"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+allow-sendfilefd debug +x509"

RDEPEND="dev-haskell/async:=[profile?]
	>=dev-haskell/auto-update-0.1.3:=[profile?]
	dev-haskell/bsb-http-chunked:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/http-date:=[profile?]
	dev-haskell/http-types:=[profile?]
	>=dev-haskell/http2-5.1:=[profile?]
	dev-haskell/iproute:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/recv:=[profile?]
	dev-haskell/simple-sendfile:=[profile?]
	dev-haskell/streaming-commons:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/time-manager:=[profile?]
	dev-haskell/vault:=[profile?]
	>=dev-haskell/wai-3.2.4:=[profile?]
	dev-haskell/word8:=[profile?]
	dev-lang/ghc:=
	x509? ( dev-haskell/crypton-x509:=[profile?] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/hspec:=[profile?]
		dev-haskell/http-client:=[profile?]
		dev-haskell/quickcheck:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' warp.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure --flag=-network-bytestring \
		"$(cabal_flag allow-sendfilefd allow-sendfilefd)" \
		"$(cabal_flag debug warp-debug)" \
		"$(cabal_flag x509 x509)"
}

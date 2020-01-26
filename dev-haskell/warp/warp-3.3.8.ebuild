# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="A fast, light-weight web server for WAI applications"
HOMEPAGE="https://github.com/yesodweb/wai"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+allow-sendfilefd warp-debug"

RDEPEND="dev-haskell/async:=[profile?]
	>=dev-haskell/auto-update-0.1.3:=[profile?]
	dev-haskell/bsb-http-chunked:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/http-date:=[profile?]
	>=dev-haskell/http-types-0.12:=[profile?]
	>=dev-haskell/http2-2.0:=[profile?]
	>=dev-haskell/iproute-1.3.1:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/semigroups:=[profile?]
	dev-haskell/simple-sendfile:=[profile?]
	dev-haskell/stm:=[profile?]
	dev-haskell/streaming-commons:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/time-manager:=[profile?]
	dev-haskell/unix-compat:=[profile?]
	dev-haskell/vault:=[profile?]
	>=dev-haskell/wai-3.2:=[profile?]
	dev-haskell/word8:=[profile?]
	dev-haskell/x509:=[profile?]
	>=dev-lang/ghc-7.10.1:="
DEPEND="${RDEPEND}"
BDEPEND=">=dev-haskell/cabal-1.22.2.0:=[profile?]
	test? ( >=dev-haskell/doctest-0.10.1:=[profile?]
		dev-haskell/hspec:=[profile?]
		dev-haskell/http-client:=[profile?]
		dev-haskell/hunit:=[profile?]
		dev-haskell/lifted-base:=[profile?]
		dev-haskell/quickcheck:2=[profile?] )"

src_configure() {
	haskell-cabal_src_configure --flag=-network-bytestring \
		"$(cabal_flag allow-sendfilefd allow-sendfilefd)" \
		"$(cabal_flag warp-debug warp-debug)"
}

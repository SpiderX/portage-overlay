# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Provides some basic WAI handlers and middleware"
HOMEPAGE="https://github.com/yesodweb/wai"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/ansi-terminal:=[profile?]
	dev-haskell/base64-bytestring:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/cookie:=[profile?]
	dev-haskell/data-default-class:=[profile?]
	dev-haskell/fast-logger:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/http2:=[profile?]
	dev-haskell/iproute:=[profile?]
	>=dev-haskell/network-2.6.1.0:=[profile?]
	dev-haskell/old-locale:=[profile?]
	dev-haskell/resourcet:=[profile?]
	>=dev-haskell/streaming-commons-0.2:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unix-compat:=[profile?]
	dev-haskell/vault:=[profile?]
	dev-haskell/void:=[profile?]
	>=dev-haskell/wai-3.0.3.0:=[profile?]
	>=dev-haskell/wai-logger-2.3.2:=[profile?]
	dev-haskell/word8:=[profile?]
	dev-haskell/zlib:=[profile?]
	>=dev-lang/ghc-7.10.1:="
DEPEND="${RDEPEND}"
BDEPEND=">=dev-haskell/cabal-1.22.2.0:=[profile?]
	test? ( dev-haskell/hspec:=[profile?]
		dev-haskell/hunit:=[profile?] )"

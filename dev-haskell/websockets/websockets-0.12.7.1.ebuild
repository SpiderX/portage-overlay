# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal linux-info

DESCRIPTION="Allows you to write WebSocket-capable servers"
HOMEPAGE="https://jaspervdj.be/websockets/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-haskell/async-2.2:=[profile?]
	dev-haskell/attoparsec:=[profile?]
	dev-haskell/base64-bytestring:=[profile?]
	dev-haskell/bytestring-builder:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	>=dev-haskell/clock-0.8:=[profile?]
	dev-haskell/entropy:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/sha:=[profile?]
	dev-haskell/streaming-commons:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-lang/ghc-8.0.1:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/hunit:=[profile?]
		>=dev-haskell/quickcheck-2.7:=[profile?]
		dev-haskell/test-framework:=[profile?]
		dev-haskell/test-framework-hunit:=[profile?]
		dev-haskell/test-framework-quickcheck2:=[profile?] )"

src_test() {
	if linux_config_exists && linux_chkconfig_present IPV6 ; then
		haskell-cabal_src_test
	fi
}

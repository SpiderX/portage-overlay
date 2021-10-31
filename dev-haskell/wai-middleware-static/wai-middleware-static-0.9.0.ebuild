# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="WAI middleware that serves requests to static files"
HOMEPAGE="https://github.com/scotty-web/wai-middleware-static"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/cryptonite:=[profile?]
	dev-haskell/expiring-cache-map:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/memory:=[profile?]
	dev-haskell/mime-types:=[profile?]
	dev-haskell/old-locale:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/wai:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec:=[profile?]
		dev-haskell/hspec-expectations-lifted:=[profile?]
		dev-haskell/hspec-wai:=[profile?]
		dev-haskell/mockery:=[profile?]
		dev-haskell/scotty:=[profile?]
		dev-haskell/wai-extra:=[profile?] )"

src_prepare() {
	default

	sed -i '/License-file/d' wai-middleware-static.cabal \
		|| die "sed failed"
}

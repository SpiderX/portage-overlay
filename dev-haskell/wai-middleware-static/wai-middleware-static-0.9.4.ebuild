# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="WAI middleware that serves requests to static files"
HOMEPAGE="https://github.com/scotty-web/wai-middleware-static"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/base16-bytestring:=[profile?]
	dev-haskell/cryptohash-sha1:=[profile?]
	dev-haskell/expiring-cache-map:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/mime-types:=[profile?]
	dev-haskell/semigroups:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/wai:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/hspec
		dev-haskell/hspec-expectations-lifted
		dev-haskell/hspec-wai
		dev-haskell/mockery
		dev-haskell/scotty
		dev-haskell/wai-extra )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/License-file/d' wai-middleware-static.cabal || die "sed failed"
}

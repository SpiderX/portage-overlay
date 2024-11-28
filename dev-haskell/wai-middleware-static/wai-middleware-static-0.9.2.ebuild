# Copyright 1999-2024 Gentoo Authors
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
	dev-haskell/old-locale:=[profile?]
	dev-haskell/semigroups:=[profile?]
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
	haskell-cabal_src_prepare
	sed -i '/License-file/d' wai-middleware-static.cabal || die "sed failed"
}

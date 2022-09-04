# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=7
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Haskell web framework"
HOMEPAGE="https://github.com/scotty-web/scotty"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/base-compat-batteries:=[profile?]
	dev-haskell/blaze-builder:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/data-default-class:=[profile?]
	>=dev-haskell/exceptions-0.7:=[profile?]
	dev-haskell/fail:=[profile?]
	dev-haskell/http-types:=[profile?]
	>=dev-haskell/monad-control-1.0.1.0:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/nats:=[profile?]
	>=dev-haskell/network-2.6.0.2:=[profile?]
	dev-haskell/regex-compat:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/transformers:=[profile?]
	dev-haskell/transformers-base:=[profile?]
	>=dev-haskell/transformers-compat-0.4:=[profile?]
	>=dev-haskell/wai-3.0.0:=[profile?]
	dev-haskell/wai-extra:=[profile?]
	dev-haskell/warp:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/async:=[profile?]
		>=dev-haskell/hspec-2:=[profile?]
		dev-haskell/hspec-wai:=[profile?]
		dev-haskell/lifted-base:=[profile?] )"

src_configure() {
	haskell-cabal_src_configure --flag=-hpc-coveralls
}

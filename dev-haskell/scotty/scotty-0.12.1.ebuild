# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=2
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Haskell web framework"
HOMEPAGE="https://github.com/scotty-web/scotty"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/base-compat-batteries:=[profile?]
	dev-haskell/blaze-builder:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/data-default-class:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/monad-control:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/regex-compat:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/transformers-base:=[profile?]
	dev-haskell/transformers-compat:=[profile?]
	dev-haskell/wai:=[profile?]
	dev-haskell/wai-extra:=[profile?]
	dev-haskell/warp:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/async
		dev-haskell/hspec
		dev-haskell/hspec-wai
		dev-haskell/lifted-base )"

CABAL_CHDEPS=(
	'warp                  >= 3.0.13   && < 3.4' 'warp                  >= 3.0.13'
	'bytestring            >= 0.10.0.2 && < 0.12' 'bytestring >=0.10.0.2'
	'data-default-class    >= 0.0.1    && < 0.2' 'data-default-class    >= 0.0.1'
	'network               >= 2.6.0.2  && < 3.2' 'network               >= 2.6.0.2'
	'text                  >= 0.11.3.1 && < 2.1' 'text                  >= 0.11.3.1'
)

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' scotty.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure --flag=-hpc-coveralls
}

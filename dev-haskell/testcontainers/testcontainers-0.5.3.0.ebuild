# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Docker containers for your integration tests"
HOMEPAGE="https://github.com/testcontainers/testcontainers-hs"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # needs docker

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/async:=[profile?]
	dev-haskell/http-client:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/optics-core:=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/resourcet:=[profile?]
	dev-haskell/tasty:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unliftio-core:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( app-containers/docker
		app-containers/docker-cli
		dev-haskell/hspec
		dev-haskell/tasty-discover
		dev-haskell/tasty-hspec
		dev-haskell/tasty-hunit )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' testcontainers.cabal || die "sed failed"
}

# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Test discovery for the tasty framework"
HOMEPAGE="https://github.com/haskell-works/tasty-discover"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+executable"

RDEPEND="dev-haskell/ansi-terminal:=[profile?]
	dev-haskell/glob:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hedgehog
	dev-haskell/hspec
	dev-haskell/hspec-core
	dev-haskell/tasty
	dev-haskell/tasty-expected-failure
	dev-haskell/tasty-golden
	dev-haskell/tasty-hedgehog
	dev-haskell/tasty-hspec
	dev-haskell/tasty-hunit
	dev-haskell/tasty-quickcheck
	dev-haskell/tasty-smallcheck
	dev-haskell/temporary )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' tasty-discover.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure "$(cabal_flag executable)"
}

src_compile() {
	LD_LIBRARY_PATH="${S}/dist/build:${LD_LIBRARY_PATH}" haskell-cabal_src_compile
}

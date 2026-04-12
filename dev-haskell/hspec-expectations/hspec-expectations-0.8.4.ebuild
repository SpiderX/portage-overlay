# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Catchy combinators for HUnit"
HOMEPAGE="https://github.com/hspec/hspec-expectations"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/call-stack:=[profile?]
	dev-haskell/hunit:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hunit
		dev-haskell/nanospec )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' hspec-expectations.cabal || die "sed failed"
}

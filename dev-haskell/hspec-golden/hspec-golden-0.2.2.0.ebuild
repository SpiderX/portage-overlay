# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Golden tests for hspec"
HOMEPAGE="https://github.com/stackbuilders/hspec-golden"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/ansi-terminal:=[profile?]
	dev-haskell/hspec-core:=[profile?]
	dev-haskell/optparse-applicative:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec
		dev-haskell/silently )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' hspec-golden.cabal || die "sed failed"
}

# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Automatically discover and run Hspec tests"
HOMEPAGE="https://github.com/hspec/hspec"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( ~dev-haskell/hspec-meta-2.11.17
		dev-haskell/mockery
		dev-haskell/quickcheck )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' hspec-discover.cabal || die "sed failed"
}

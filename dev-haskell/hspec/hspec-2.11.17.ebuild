# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="A Testing Framework for Haskell"
HOMEPAGE="https://github.com/hspec/hspec"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="~dev-haskell/hspec-core-2.11.17:=[profile?]
	~dev-haskell/hspec-discover-2.11.17:=[profile?]
	>=dev-haskell/hspec-expectations-0.8.4:=[profile?]
	dev-haskell/quickcheck:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' hspec.cabal || die "sed failed"
}

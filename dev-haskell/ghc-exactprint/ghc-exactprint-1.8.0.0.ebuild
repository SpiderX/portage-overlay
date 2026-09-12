# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="ExactPrint for GHC"
HOMEPAGE="https://github.com/alanz/ghc-exactprint"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="dev-haskell/data-default:=[profile?]
	dev-haskell/free:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/ordered-containers:=[profile?]
	dev-haskell/syb:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/cabal-syntax
		dev-haskell/diff
		dev-haskell/extra
		dev-haskell/filemanip
		dev-haskell/ghc-paths
		dev-haskell/hunit
		dev-haskell/silently
		dev-haskell/temporary
		dev-haskell/turtle )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' ghc-exactprint.cabal || die "sed failed"
}

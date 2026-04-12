# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="A ByteString builder implementation based on the binary tree"
HOMEPAGE="https://github.com/nikita-volkov/bytestring-tree-builder"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/base-prelude
		dev-haskell/quickcheck-instances
		dev-haskell/tasty
		dev-haskell/tasty-hunit
		dev-haskell/tasty-quickcheck )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' bytestring-tree-builder.cabal \
		|| die "sed failed"
}

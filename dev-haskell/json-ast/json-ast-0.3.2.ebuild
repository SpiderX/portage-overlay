# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Universal JSON AST datastructure"
HOMEPAGE="https://github.com/nikita-volkov/json-ast"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/scientific:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	haskell-cabal_src_prepare
	cabal-mksetup
	sed -i '/license-file/,+1d' json-ast.cabal || die "sed failed"
}

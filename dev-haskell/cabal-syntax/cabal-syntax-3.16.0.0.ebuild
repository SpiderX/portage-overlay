# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_PN="Cabal-syntax"
CABAL_FEATURES="lib profile haddock hoogle hscolour nocabaldep"

inherit haskell-cabal

DESCRIPTION="A library for working with .cabal files"
HOMEPAGE="https://github.com/haskell/cabal"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/parsec:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/alex
	dev-haskell/cabal:="

DOCS=( {ChangeLog,README}.md )

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' Cabal-syntax.cabal || die "sed failed"
}

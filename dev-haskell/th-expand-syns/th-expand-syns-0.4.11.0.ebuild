# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=4
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Expands type synonyms in Template Haskell ASTs"
HOMEPAGE="https://github.com/DanielSchuessler/th-expand-syns"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/syb:=[profile?]
	dev-haskell/th-abstraction:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' th-expand-syns.cabal || die "sed failed"
}

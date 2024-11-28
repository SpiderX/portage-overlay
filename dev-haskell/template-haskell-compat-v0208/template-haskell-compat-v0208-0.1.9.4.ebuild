# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Backward-compatibility layer for Template Haskell newer than 2.8"
HOMEPAGE="https://github.com/nikita-volkov/template-haskell-compat-v0208"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	haskell-cabal_src_prepare
	cabal-mksetup
	sed -i '/license-file/d' template-haskell-compat-v0208.cabal \
		|| die "sed failed"
}

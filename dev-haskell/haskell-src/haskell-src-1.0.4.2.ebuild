# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Support for manipulating Haskell source code"
HOMEPAGE="https://github.com/haskell-pkg-janitors/haskell-src"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/syb:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}
	dev-haskell/happy"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' haskell-src.cabal || die "sed failed"
}

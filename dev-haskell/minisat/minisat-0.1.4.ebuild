# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="A Haskell bundle of the Minisat SAT solver"
HOMEPAGE="https://hackage.haskell.org/package/minisat"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/async:=[profile?]
	|| ( llvm-core/clang sys-devel/gcc[cxx] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' minisat.cabal || die "sed failed"
}

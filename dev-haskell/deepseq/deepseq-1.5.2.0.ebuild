# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Deep evaluation of data structures"
HOMEPAGE="https://github.com/haskell/deepseq"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

DOCS=( changelog.md )

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' deepseq.cabal || die "sed failed"
}

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Commutative semigroups"
HOMEPAGE="https://github.com/obsidiansystems/commutative-semigroups"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

DOCS=( {ChangeLog,ReadMe}.md )

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' commutative-semigroups.cabal || die "sed failed"
}

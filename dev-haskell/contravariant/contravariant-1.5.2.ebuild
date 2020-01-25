# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Contravariant functors"
HOMEPAGE="https://github.com/ekmett/contravariant"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+semigroups +statevar +tagged"

RDEPEND=">=dev-haskell/transformers-compat-0.3:=[profile?]
	dev-haskell/void:=[profile?]
	dev-lang/ghc:=
	semigroups? ( >=dev-haskell/semigroups-0.15.2:=[profile?] )
	statevar? ( >=dev-haskell/statevar-1.1.1:=[profile?] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"

src_configure() {
	haskell-cabal_src_configure \
		"$(cabal_flag semigroups semigroups)" \
		"$(cabal_flag statevar statevar)" \
		"$(cabal_flag tagged tagged)"
}

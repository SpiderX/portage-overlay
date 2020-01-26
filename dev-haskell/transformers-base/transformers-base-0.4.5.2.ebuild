# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Lift computations from the bottom of a transformer stack"
HOMEPAGE="https://github.com/mvv/transformers-base"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+orphaninstances"

RDEPEND="dev-haskell/stm:=[profile?]
	>=dev-haskell/transformers-compat-0.6.1:=[profile?]
	dev-lang/ghc:=
	orphaninstances? ( dev-haskell/base-orphans:=[profile?] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"

src_configure() {
	haskell-cabal_src_configure \
		"$(cabal_flag orphaninstances orphaninstances)"
}

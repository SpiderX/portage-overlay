# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib nocabaldep profile test-suite"

inherit haskell-cabal

DESCRIPTION="Natural numbers"
HOMEPAGE="https://github.com/ekmett/nats"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+binary +hashable +template-haskell"

RDEPEND="dev-lang/ghc:=
	binary? ( dev-haskell/binary:=[profile?] )
	hashable? ( dev-haskell/hashable:=[profile?] )"
DEPEND="${RDEPEND}"

src_configure() {
	haskell-cabal_src_configure \
		"$(cabal_flag binary binary)" \
		"$(cabal_flag hashable hashable)" \
		"$(cabal_flag template-haskell template-haskell)"
}

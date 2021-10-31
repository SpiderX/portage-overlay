# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Singleton Tuple"
HOMEPAGE="https://github.com/haskellari/OneTuple"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/base-orphans:=[profile?]
	dev-haskell/semigroups:=[profile?]
	dev-haskell/transformers-compat:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	default

	cabal_chdeps \
		'base-orphans >=0.8.6' 'base-orphans >=0.8.4'

	sed -i '/license-file/d' OneTuple.cabal \
		|| die "sed failed"
}

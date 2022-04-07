# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Optics as an abstract interface"
HOMEPAGE="https://github.com/well-typed/optics"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="explicit-generic-labels"

RDEPEND="dev-haskell/indexed-profunctors:=[profile?]
	dev-haskell/indexed-traversable:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	default

	sed -i '/license-file/d' optics-core.cabal \
		|| die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure \
		"$(cabal_flag explicit-generic-labels explicit-generic-labels)"
}

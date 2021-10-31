# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Optics as an abstract interface"
HOMEPAGE="https://github.com/well-typed/optics"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/mtl:=[profile?]
	dev-haskell/optics-core:=[profile?]
	dev-haskell/th-abstraction:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/tagged:=[profile?] )"

src_prepare() {
	default

	cabal_chdeps \
		'optics-core            >= 0.3       && <0.4' 'optics-core            >= 0.3'

	sed -i '/license-file/d' optics-th.cabal \
		|| die "sed failed"
}

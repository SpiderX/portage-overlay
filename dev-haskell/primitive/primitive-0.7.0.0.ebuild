# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Primitive memory-related operations"
HOMEPAGE="https://github.com/haskell/primitive"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/fail:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( >=dev-haskell/quickcheck-2.13:2=[profile?] )"

src_prepare() {
	default

	# Decrease cabal version requirement
	sed -i '/Cabal-Version/s/2.2/1.10/' primitive.cabal || die "sed failed"

	cabal_chdeps \
		'QuickCheck ^>= 2.13' 'QuickCheck >= 2.13' \
		'tasty ^>= 1.2' 'tasty >= 1.2'
}

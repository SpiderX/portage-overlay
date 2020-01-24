# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="High-resolution clock functions"
HOMEPAGE="https://github.com/corsis/clock"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

src_configure() {
	haskell-cabal_src_configure --flag=-llvm
}

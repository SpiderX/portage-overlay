# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Distributive functors"
HOMEPAGE="https://github.com/ekmett/distributive"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/base-orphans-0.5.2:=[profile?]
	>=dev-haskell/semigroups-0.13:=[profile?]
	>=dev-haskell/tagged-0.7:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	dev-haskell/cabal-doctest:=[profile?]
	test? ( >=dev-haskell/doctest-0.11.1:=[profile?]
		>=dev-haskell/generic-deriving-1.11:=[profile?]
		>=dev-haskell/hspec-2:=[profile?] )"

src_configure() {
	haskell-cabal_src_configure --flag=semigroups --flag=tagged
}

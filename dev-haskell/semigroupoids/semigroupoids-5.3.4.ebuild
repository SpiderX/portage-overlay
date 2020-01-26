# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Semigroupoids: Category sans id"
HOMEPAGE="https://github.com/ekmett/semigroupoids"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+comonad +containers +contravariant +distributive +tagged +unordered-containers"

RDEPEND=">=dev-haskell/base-orphans-0.8:=[profile?]
	>=dev-haskell/bifunctors-5:=[profile?]
	>=dev-haskell/semigroups-0.16.2:=[profile?]
	>=dev-haskell/transformers-compat-0.5:=[profile?]
	dev-lang/ghc:=
	comonad? ( >=dev-haskell/comonad-4.2.6:=[profile?] )
	contravariant? ( dev-haskell/contravariant:=[profile?] )
	distributive? ( dev-haskell/distributive:=[profile?] )
	tagged? ( >=dev-haskell/tagged-0.8.5:=[profile?] )
	unordered-containers? ( dev-haskell/hashable:=[profile?]
				dev-haskell/unordered-containers:=[profile?] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	dev-haskell/cabal-doctest:=[profile?]
	test? ( >=dev-haskell/doctest-0.11.1:=[profile?] )"

src_configure() {
	haskell-cabal_src_configure --flag=doctests \
		"$(cabal_flag comonad comonad)" \
		"$(cabal_flag containers containers)" \
		"$(cabal_flag contravariant contravariant)" \
		"$(cabal_flag distributive distributive)" \
		"$(cabal_flag tagged tagged)" \
		"$(cabal_flag unordered-containers unordered-containers)"
}

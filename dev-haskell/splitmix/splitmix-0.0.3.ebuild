# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Fast Splittable PRNG"
HOMEPAGE="https://github.com/phadej/splitmix"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="optimised-mixer +random"

RDEPEND="dev-lang/ghc:=
	random? ( dev-haskell/random:=[profile?] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( >=dev-haskell/async-2.2.2:=[profile?]
		dev-haskell/base-compat-batteries:=[profile?]
		dev-haskell/random:=[profile?]
		dev-haskell/tf-random:=[profile?]
		>=dev-haskell/vector-0.11.0.0:=[profile?] )"

src_prepare() {
	default

	cabal_chdeps \
		'base-compat-batteries  >=0.10.5   && <0.11' 'base-compat-batteries  >=0.10.5'
}

src_configure() {
	haskell-cabal_src_configure \
		"$(cabal_flag optimised-mixer optimised-mixer)" \
		"$(cabal_flag random random)"
}

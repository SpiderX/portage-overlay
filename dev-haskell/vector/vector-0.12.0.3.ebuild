# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Efficient Arrays"
HOMEPAGE="https://github.com/haskell/vector"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+boundschecks internalchecks unsafechecks"

RDEPEND="dev-haskell/fail:=[profile?]
	dev-haskell/primitive:=[profile?]
	>=dev-haskell/semigroups-0.18:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( >=dev-haskell/base-orphans-0.6:=[profile?]
		>=dev-haskell/quickcheck-2.9:2=[profile?]
		dev-haskell/hunit:=[profile?]
		dev-haskell/test-framework:=[profile?]
		dev-haskell/test-framework-hunit:=[profile?]
		dev-haskell/test-framework-quickcheck2:=[profile?] )"

src_prepare() {
	default

	cabal_chdeps \
		'base >= 4.5 && < 4.13' 'base >= 4.5' \
		'QuickCheck >= 2.9 && < 2.10' 'QuickCheck >= 2.9'
}

src_configure() {
	haskell-cabal_src_configure --flag=-wall \
		"$(cabal_flag boundschecks boundschecks)" \
		"$(cabal_flag internalchecks internalchecks)" \
		"$(cabal_flag unsafechecks unsafechecks)"
}

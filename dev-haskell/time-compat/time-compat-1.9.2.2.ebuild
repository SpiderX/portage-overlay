# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Compatibility with old-time for the time package"
HOMEPAGE="https://github.com/phadej/time-compat"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/base-orphans-0.8.1:=[profile?]
	dev-haskell/fail:=[profile?]
	dev-haskell/old-locale:=[profile?]
	>=dev-haskell/semigroups-0.18.5:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( >=dev-haskell/base-compat-0.10.5:=[profile?]
		>=dev-haskell/hunit-1.6:=[profile?]
		>=dev-haskell/quickcheck-2.13:2=[profile?]
		>=dev-haskell/tagged-0.8.6:=[profile?]
		>=dev-haskell/tasty-1.2.1:=[profile?]
		>=dev-haskell/tasty-hunit-0.10:=[profile?]
		>=dev-haskell/tasty-quickcheck-0.10:=[profile?] )"

src_prepare() {
	default

	cabal_chdeps \
		'time          >=1.2     && <1.3 || >=1.4 && <1.7 || >=1.8 && <1.9 || >=1.9.2 && <1.9.3' 'time          >=1.2     && <1.3 || >=1.4 && <1.7 || >=1.8 && <1.9 || >=1.9.2 && <1.9.4' \
		'base-compat       >=0.10.5 && <0.11' 'base-compat       >=0.10.5'
}

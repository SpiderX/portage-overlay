# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Common quickcheck instances"
HOMEPAGE="https://github.com/phadej/qc-instances"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/base-compat-0.9.3:=[profile?]
	>=dev-haskell/case-insensitive-1.2.0.4:=[profile?]
	>=dev-haskell/hashable-1.2.5.0:=[profile?]
	>=dev-haskell/nats-1:=[profile?]
	>=dev-haskell/old-time-1.1.0.0:=[profile?]
	>=dev-haskell/quickcheck-2.13.2:2=[profile?]
	dev-haskell/scientific:=[profile?]
	>=dev-haskell/semigroups-0.18.5:=[profile?]
	>=dev-haskell/splitmix-0.0.2:=[profile?]
	>=dev-haskell/tagged-0.8.5:=[profile?]
	>=dev-haskell/text-1.0.0.0:=[profile?]
	>=dev-haskell/time-compat-1.9.2.2:=[profile?]
	>=dev-haskell/transformers-compat-0.5:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/uuid-types:=[profile?]
	dev-haskell/vector:=[profile?]
	>=dev-haskell/void-0.7.2:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"

src_prepare() {
	default

	cabal_chdeps \
		'base       >=4.5    && <4.13' 'base       >=4.5' \
		'base-compat          >=0.9.3   && <0.11' 'base-compat          >=0.9.3'
}

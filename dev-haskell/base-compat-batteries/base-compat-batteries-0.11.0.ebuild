# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Base-compat with extra batteries"
HOMEPAGE="https://github.com/haskell-compat/base-compat"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/base-compat-0.11.0:=[profile?]
	>=dev-haskell/bifunctors-5.5.2:=[profile?]
	>=dev-haskell/contravariant-1.5:=[profile?]
	dev-haskell/fail:=[profile?]
	>=dev-haskell/nats-1.1.2:=[profile?]
	>=dev-haskell/semigroups-0.18.4:=[profile?]
	>=dev-haskell/transformers-compat-0.6:=[profile?]
	dev-haskell/type-equality:=[profile?]
	>=dev-haskell/void-0.7.2:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( >=dev-haskell/hspec-1.8:=[profile?]
		dev-haskell/hspec-discover:=[profile?]
		dev-haskell/quickcheck:2=[profile?] )"

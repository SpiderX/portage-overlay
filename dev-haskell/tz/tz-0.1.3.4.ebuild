# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Library for time zone conversions"
HOMEPAGE="https://github.com/nilcons/haskell-tz"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+template-haskell"

RDEPEND="dev-haskell/data-default:=[profile?]
	dev-haskell/tzdata:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/hunit:=[profile?]
		dev-haskell/quickcheck:=[profile?]
		dev-haskell/test-framework:=[profile?]
		dev-haskell/test-framework-hunit:=[profile?]
		dev-haskell/test-framework-quickcheck2:=[profile?]
		dev-haskell/test-framework-th:=[profile?] )"

src_prepare() {
	default

	cabal_chdeps \
		'time                       >= 1.2     && < 1.10' 'time                       >= 1.2' \
		'template-haskell   >= 2.6      && < 2.17' 'template-haskell   >= 2.6'
}

src_configure() {
	haskell-cabal_src_configure \
		"$(cabal_flag template-haskell template-haskell)"
}

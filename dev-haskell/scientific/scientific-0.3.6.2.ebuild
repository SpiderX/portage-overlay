# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Numbers represented using scientific notation"
HOMEPAGE="https://github.com/basvandijk/scientific"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="integer-simple"

RDEPEND="dev-haskell/bytestring-builder:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/integer-logarithms:=[profile?]
	dev-haskell/primitive:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:=
	integer-simple? ( dev-haskell/integer-simple:=[profile?] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/quickcheck:2=[profile?]
		dev-haskell/smallcheck:=[profile?]
		>=dev-haskell/tasty-0.5:=[profile?]
		dev-haskell/tasty-ant-xml:=[profile?]
		>=dev-haskell/tasty-hunit-0.8:=[profile?]
		>=dev-haskell/tasty-quickcheck-0.8:=[profile?]
		dev-haskell/tasty-smallcheck:=[profile?] )"

src_configure() {
	haskell-cabal_src_configure \
		"$(cabal_flag integer-simple integer-simple)"
}

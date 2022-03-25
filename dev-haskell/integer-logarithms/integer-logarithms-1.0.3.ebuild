# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Integer logarithms"
HOMEPAGE="https://github.com/Bodigrim/integer-logarithms"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+integer-gmp"

RDEPEND=">=dev-haskell/nats-1.1.2:=[profile?]
	dev-lang/ghc:=
	!integer-gmp? ( dev-haskell/integer-simple:=[profile?] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( >=dev-haskell/quickcheck-2.10:2=[profile?]
		>=dev-haskell/smallcheck-1.1.3:=[profile?]
		>=dev-haskell/tasty-0.10:=[profile?]
		>=dev-haskell/tasty-hunit-0.9:=[profile?]
		>=dev-haskell/tasty-quickcheck-0.8:=[profile?]
		>=dev-haskell/tasty-smallcheck-0.8:=[profile?] )"

src_prepare() {
	default

	cabal_chdeps \
		'base >= 4.3 && < 4.13' 'base >= 4.3'
}

src_configure() {
	haskell-cabal_src_configure --flag=-check-bounds \
		"$(cabal_flag integer-gmp integer-gmp)"
}

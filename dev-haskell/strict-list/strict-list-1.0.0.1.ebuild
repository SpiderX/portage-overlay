# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Strict linked list"
HOMEPAGE="https://github.com/nikita-volkov/strict-list"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/hashable:=[profile?]
	dev-haskell/quickcheck:=[profile?]
	dev-haskell/semigroupoids:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/rerebase
		dev-haskell/tasty-hunit
		dev-haskell/tasty-quickcheck )"

CABAL_CHDEPS=(
	'tasty >=1.5.4 && <1.6' 'tasty >=1.4.2.3 && <1.6'
	'tasty-quickcheck >=0.11.1 && <0.12' 'tasty-quickcheck >=0.10.2 && <0.12'
)

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' strict-list.cabal || die "sed failed"
}

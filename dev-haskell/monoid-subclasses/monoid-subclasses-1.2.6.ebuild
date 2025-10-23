# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Subclasses of Monoid"
HOMEPAGE="https://github.com/blamario/monoid-subclasses"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/commutative-semigroups:=[profile?]
	dev-haskell/primes:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/quickcheck:=[profile?]
		dev-haskell/quickcheck-instances:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' monoid-subclasses.cabal || die "sed failed"
}

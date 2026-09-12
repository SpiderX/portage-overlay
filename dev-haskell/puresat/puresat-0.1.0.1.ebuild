# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Pure Haskell SAT-solver"
HOMEPAGE="https://github.com/phadej/puresat"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="exe"

RDEPEND="dev-haskell/parsec:=[profile?]
	dev-haskell/primitive:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/minisat
		dev-haskell/tasty
		dev-haskell/tasty-hunit
		dev-haskell/tasty-quickcheck
		dev-haskell/quickcheck )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' puresat.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure "$(cabal_flag exe exe)"
}

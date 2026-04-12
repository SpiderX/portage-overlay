# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=2
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="An either monad transformer"
HOMEPAGE="https://github.com/ekmett/either"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/bifunctors:=[profile?]
	dev-haskell/profunctors:=[profile?]
	dev-haskell/semigroupoids:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/tasty
		dev-haskell/tasty-quickcheck
		dev-haskell/quickcheck )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' either.cabal || die "sed failed"
}

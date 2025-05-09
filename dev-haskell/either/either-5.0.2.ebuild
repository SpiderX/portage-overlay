# Copyright 1999-2024 Gentoo Authors
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
	test? ( dev-haskell/quickcheck:=
		dev-haskell/test-framework:=
		dev-haskell/test-framework-quickcheck2:= )"

src_prepare() {
	haskell-cabal_src_prepare
	cabal-mksetup
	sed -i '/license-file/d' either.cabal || die "sed failed"
}

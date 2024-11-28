# Copyright 1999-2024 Gentoo Authors
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
	dev-haskell/semigroupoids:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/rerebase:=[profile?]
		dev-haskell/tasty-hunit:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	cabal-mksetup
	sed -i '/license-file/d' strict-list.cabal || die "sed failed"
}

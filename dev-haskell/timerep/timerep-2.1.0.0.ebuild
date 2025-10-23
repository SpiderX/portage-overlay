# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Parse and display time according to some RFCs"
HOMEPAGE="https://github.com/HugoDaniel/timerep"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/attoparsec:=[profile?]
	dev-haskell/monoid-subclasses:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/quickcheck:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-hunit:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

DOCS=( {CHANGES,README}.md )

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' timerep.cabal || die "sed failed"
}

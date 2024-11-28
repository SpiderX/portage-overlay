# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Abstract interace for Haskell text builders/printers"
HOMEPAGE="https://github.com/mvv/text-printer"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/semigroups:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/text-latin1:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/quickcheck:=[profile?]
		dev-haskell/test-framework:=[profile?]
		dev-haskell/test-framework-quickcheck2:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/License-File/d' text-printer.cabal || die "sed failed"
}

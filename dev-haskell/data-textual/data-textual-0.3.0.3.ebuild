# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Human-friendly textual representations for Haskell"
HOMEPAGE="https://github.com/mvv/data-textual"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/parsers:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/text-latin1:=[profile?]
	dev-haskell/text-printer:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/quickcheck:2=[profile?]
		dev-haskell/test-framework:=[profile?]
		dev-haskell/test-framework-quickcheck2:=[profile?]
		dev-haskell/type-hint:=[profile?] )"

src_prepare() {
	default

	sed -i '/License-File/d' data-textual.cabal \
		|| die "sed failed"
}

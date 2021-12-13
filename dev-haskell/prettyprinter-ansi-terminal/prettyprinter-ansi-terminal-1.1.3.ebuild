# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="ANSI terminal backend for prettyprinter package"
HOMEPAGE="https://github.com/quchen/prettyprinter"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/ansi-terminal:=[profile?]
	>=dev-haskell/prettyprinter-1.7.0:=[profile?]
	dev-haskell/semigroups:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/doctest:=[profile?] )"

src_prepare() {
	default

	sed -i '/license-file/d' prettyprinter-ansi-terminal.cabal \
		|| die "sed failed"
}

# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Native wcwidth"
HOMEPAGE="https://github.com/solidsnack/wcwidth"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="cli"

RDEPEND="dev-lang/ghc:=
	cli? ( dev-haskell/attoparsec:=[profile?]
		dev-haskell/setlocale:=[profile?]
		dev-haskell/utf8-string:=[profile?] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"

src_configure() {
	haskell-cabal_src_configure "$(cabal_flag cli cli)"
}

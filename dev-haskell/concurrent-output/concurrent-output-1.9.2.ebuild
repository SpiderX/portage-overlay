# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Ungarble output from several threads or commands"
HOMEPAGE="https://git.joeyh.name/index.cgi/concurrent-output.git"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/ansi-terminal:=[profile?]
	dev-haskell/async:=[profile?]
	>=dev-haskell/exceptions-0.6.0:=[profile?]
	dev-haskell/stm:=[profile?]
	dev-haskell/terminal-size:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-lang/ghc-8:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"

src_prepare() {
	default

	cabal_chdeps \
		'ansi-terminal (>= 0.6.0 && < 0.7.0)' 'ansi-terminal >= 0.6.0' \
		'async (>= 2.0 && < 2.2)' 'async >= 2.0' \
		'exceptions (>= 0.6.0 && < 0.9.0)' 'exceptions >= 0.6.0'
}

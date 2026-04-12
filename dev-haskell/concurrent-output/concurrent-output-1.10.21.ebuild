# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Ungarble output from several threads or commands"
HOMEPAGE="https://hackage.haskell.org/package/concurrent-output"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/ansi-terminal:=[profile?]
	dev-haskell/async:=[profile?]
	dev-haskell/terminal-size:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' concurrent-output.cabal \
		|| die "sed failed"
}

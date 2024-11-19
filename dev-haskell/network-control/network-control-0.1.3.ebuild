# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Library to control network protocols"
HOMEPAGE="https://hackage.haskell.org/package/network-control"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/psqueues:=[profile?]
	dev-haskell/unix-time:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec:=[profile?]
		dev-haskell/pretty-simple:=[profile?]
		dev-haskell/quickcheck:=[profile?]
		dev-haskell/text:=[profile?] )"

src_prepare() {
	default

	sed -i '/license-file/d' network-control.cabal \
		|| die "sed failed"

	cabal-mksetup
}

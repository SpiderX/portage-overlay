# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="A version of Hspec which is used to test Hspec itself"
HOMEPAGE="http://hspec.github.io"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/ansi-terminal:=[profile?]
	dev-haskell/call-stack:=[profile?]
	dev-haskell/clock:=[profile?]
	>=dev-haskell/hspec-expectations-0.8.2:=[profile?]
	dev-haskell/hunit:=[profile?]
	>=dev-haskell/quickcheck-2.10:2=[profile?]
	dev-haskell/quickcheck-io:=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/setenv:=[profile?]
	dev-haskell/stm:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"

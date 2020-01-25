# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="A fast logging system"
HOMEPAGE="https://github.com/kazu-yamamoto/logger"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/auto-update:=[profile?]
	dev-haskell/easy-file:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unix-compat:=[profile?]
	>=dev-haskell/unix-time-0.4.4:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/hspec:=[profile?] )"

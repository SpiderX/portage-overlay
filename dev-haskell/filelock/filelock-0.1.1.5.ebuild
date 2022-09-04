# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Portable interface to file locking"
HOMEPAGE="https://github.com/takano-akio/filelock"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/async:=[profile?] )"

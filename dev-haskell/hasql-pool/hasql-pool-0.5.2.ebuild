# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="A pool of connections for Hasql"
HOMEPAGE="https://github.com/nikita-volkov/hasql-pool"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND="dev-haskell/base-prelude:=[profile?]
	dev-haskell/hasql:=[profile?]
	dev-haskell/resource-pool:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec:=[profile?] )"

src_prepare() {
	default

	sed -i '/license-file/,+1d' hasql-pool.cabal \
		|| die "sed failed"
}

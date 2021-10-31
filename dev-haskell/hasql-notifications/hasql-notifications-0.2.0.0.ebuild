# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="PostgreSQL Asynchronous notification"
HOMEPAGE="https://github.com/diogob/hasql-notifications"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND="dev-haskell/contravariant:=[profile?]
	dev-haskell/hasql:=[profile?]
	dev-haskell/hasql-pool:=[profile?]
	dev-haskell/postgresql-libpq:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec:=[profile?]
		dev-haskell/quickcheck:2=[profile?] )"

src_prepare() {
	default

	sed -i '/license-file/d' hasql-notifications.cabal \
		|| die "sed failed"
}

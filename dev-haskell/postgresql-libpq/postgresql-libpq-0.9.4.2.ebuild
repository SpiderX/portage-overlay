# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="low-level binding to libpq"
HOMEPAGE="https://github.com/phadej/postgresql-libpq"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/ghc:=
	dev-db/postgresql:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	virtual/pkgconfig"

src_prepare() {
	default

	cabal_chdeps \
		'base       >=4.3     && <4.13' 'base       >=4.3'
}

src_configure() {
	haskell-cabal_src_configure -f -use-pkg-config
}

# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="low-level binding to libpq"
HOMEPAGE="https://github.com/haskellari/postgresql-libpq"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-db/postgresql:=
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"

src_prepare() {
	default

	cabal_chdeps \
		'base        >=4.3     && <4.15' 'base        >=4.3' \
		'Cabal  >=1.10 && <3.3' 'Cabal  >=1.10'
}

src_configure() {
	haskell-cabal_src_configure --flag=-use-pkg-config
}

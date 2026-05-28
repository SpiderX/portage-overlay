# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"
POSTGRES_COMPAT=( {14..18} )

inherit haskell-cabal postgres

DESCRIPTION="A low-level binding to libpq for pkg-config based provider"
HOMEPAGE="https://github.com/haskellari/postgresql-libpq"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/ghc:="
DEPEND="${RDEPEND}
	${POSTGRES_DEP}"
BDEPEND="dev-haskell/cabal
	virtual/pkgconfig"

pkg_setup() {
	haskell-cabal_pkg_setup
	postgres_pkg_setup
}

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' postgresql-libpq-pkgconfig.cabal \
		|| die "sed failed"
}

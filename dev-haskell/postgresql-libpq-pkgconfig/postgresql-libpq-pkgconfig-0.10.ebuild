# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="A low-level binding to libpq for pkg-config based provider"
HOMEPAGE="https://github.com/haskellari/postgresql-libpq"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/ghc:="
DEPEND="${RDEPEND}
	dev-db/postgresql:*"
BDEPEND="dev-haskell/cabal:=
	virtual/pkgconfig"

src_prepare() {
	haskell-cabal_src_prepare
	cabal-mksetup
	sed -i '/license-file/d' postgresql-libpq-pkgconfig.cabal \
		|| die "sed failed"
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Unix time parser/formatter and utilities"
HOMEPAGE="https://hackage.haskell.org/package/unix-time"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/old-time:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec:=[profile?]
		dev-haskell/old-locale:=[profile?]
		dev-haskell/quickcheck:=[profile?] )"

src_prepare() {
	default

	sed -i '/license-file/d' unix-time.cabal \
		|| die "sed failed"
}

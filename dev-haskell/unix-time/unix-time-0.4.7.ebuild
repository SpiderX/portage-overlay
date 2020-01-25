# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Unix time parser/formatter and utilities"
HOMEPAGE="https://github.com/kazu-yamamoto/unix-time"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/old-time:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/doctest:=[profile?]
		>=dev-haskell/hspec-2.6:=[profile?]
		>=dev-haskell/hspec-discover-2.6:=[profile?]
		dev-haskell/old-locale:=[profile?]
		dev-haskell/quickcheck:2=[profile?] )"

src_prepare() {
	default

	sed -i '/Build-Tools/d' unix-time.cabal || die "sed failed"
}

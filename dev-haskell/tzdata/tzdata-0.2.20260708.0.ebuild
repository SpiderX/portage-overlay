# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Distribution of the standard time zone database"
HOMEPAGE="https://github.com/ysangkok/haskell-tzdata"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/vector:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/hunit
		dev-haskell/tasty
		dev-haskell/tasty-hunit
		dev-haskell/tasty-th )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/License-File/d' tzdata.cabal || die "sed failed"
}

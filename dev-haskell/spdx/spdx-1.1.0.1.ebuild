# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="SPDX license expression language"
HOMEPAGE="https://github.com/phadej/spdx"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="dev-haskell/puresat:=[profile?]
	dev-haskell/cabal-syntax:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/tasty
		dev-haskell/tasty-quickcheck )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' spdx.cabal || die "sed failed"
}

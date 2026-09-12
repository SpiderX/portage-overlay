# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="memory and related abstraction stuff"
HOMEPAGE="https://github.com/jappeace/ram"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/quickcheck
		dev-haskell/tasty )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' ram.cabal || die "sed failed"
}

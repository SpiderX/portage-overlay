# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Fast XML generation library"
HOMEPAGE="https://github.com/skogsbaer/xmlgen"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # https://github.com/skogsbaer/xmlgen/issues/6

RDEPEND="dev-haskell/blaze-builder:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hunit
		dev-haskell/hxt
		dev-haskell/quickcheck )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' xmlgen.cabal || die "sed failed"
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Common API for Haskell serialization libraries"
HOMEPAGE="https://github.com/mvv/data-serializer"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/cereal:=[profile?]
	dev-haskell/data-endian:=[profile?]
	dev-haskell/parsers:=[profile?]
	dev-haskell/semigroups:=[profile?]
	dev-haskell/split:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/License-File/d' data-serializer.cabal || die "sed failed"
}

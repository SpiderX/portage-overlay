# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Internet Protocol data structures"
HOMEPAGE="https://github.com/mvv/network-ip"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/data-default-class:=[profile?]
	dev-haskell/data-dword:=[profile?]
	dev-haskell/data-endian:=[profile?]
	dev-haskell/data-serializer:=[profile?]
	dev-haskell/data-textual:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/parsers:=[profile?]
	dev-haskell/text-printer:=[profile?]
	dev-haskell/type-hint:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/License-File/d' network-ip.cabal || die "sed failed"
}

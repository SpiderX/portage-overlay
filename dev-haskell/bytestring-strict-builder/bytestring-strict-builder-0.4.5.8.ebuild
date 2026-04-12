# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="An efficient strict bytestring builder"
HOMEPAGE="https://github.com/nikita-volkov/bytestring-strict-builder"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/quickcheck-instances
		dev-haskell/rerebase
		dev-haskell/tasty
		dev-haskell/tasty-quickcheck )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' bytestring-strict-builder.cabal \
		|| die "sed failed"
}

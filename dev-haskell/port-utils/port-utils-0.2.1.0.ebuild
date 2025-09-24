# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Utilities for creating and waiting on ports"
HOMEPAGE="https://github.com/jfischoff/port-utils"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-haskell/network:=[profile?]
	dev-lang/ghc:="
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/async:=[profile?]
		dev-haskell/hspec:=[profile?]
		dev-haskell/stm:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' port-utils.cabal || die "sed failed"
}

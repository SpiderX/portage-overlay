# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=6
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Compositional pipelines"
HOMEPAGE="https://github.com/Gabriella439/pipes"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/mmorph:=[profile?]
	dev-haskell/void:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/quickcheck
		dev-haskell/test-framework
		dev-haskell/test-framework-quickcheck2 )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/License-file/d' pipes.cabal || die "sed failed"
}

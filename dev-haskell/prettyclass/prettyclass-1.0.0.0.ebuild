# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Pretty printing class similar to Show"
HOMEPAGE="https://hackage.haskell.org/package/prettyclass"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal"

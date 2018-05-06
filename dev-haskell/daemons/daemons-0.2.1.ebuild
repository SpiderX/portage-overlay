# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Daemons in Haskell made fun and easy"
HOMEPAGE="https://github.com/scvalex/daemons"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/cereal-0.4.0.1:=[profile?]
	dev-haskell/data-default:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/pipes:=[profile?]
	dev-haskell/transformers:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}
	dev-haskell/cabal:="

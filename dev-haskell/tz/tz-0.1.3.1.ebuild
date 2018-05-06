# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Library for time zone conversions"
HOMEPAGE="https://github.com/nilcons/haskell-tz"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="<dev-haskell/binary-0.9:=[profile?]
	>=dev-haskell/data-default-0.5.3:=[profile?] <dev-haskell/data-default-0.8:=[profile?]
	dev-haskell/tzdata:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}
	dev-haskell/cabal:="

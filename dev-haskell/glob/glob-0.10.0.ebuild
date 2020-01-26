# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

MY_PN="Glob"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Globbing library"
HOMEPAGE="http://iki.fi/matti.niemenmaa/glob"
SRC_URI="https://hackage.haskell.org/package/${MY_P}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/dlist:=[profile?]
	>=dev-haskell/semigroups-0.18:=[profile?]
	>=dev-haskell/transformers-compat-0.3:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND=">=dev-haskell/cabal-1.18.1.3:=[profile?]
	test? ( dev-haskell/hunit:=[profile?]
		dev-haskell/quickcheck:2=[profile?]
		dev-haskell/test-framework:=[profile?]
		dev-haskell/test-framework-hunit:=[profile?]
		dev-haskell/test-framework-quickcheck2:=[profile?] )"

S="${WORKDIR}/${MY_P}"

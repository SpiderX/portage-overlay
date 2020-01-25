# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

MY_PN="QuickCheck"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Automatic testing of Haskell programs"
HOMEPAGE="https://github.com/nick8325/quickcheck"
SRC_URI="https://hackage.haskell.org/package/${MY_P}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="2/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+template-haskell"

RDEPEND="dev-haskell/random:=[profile?]
	dev-haskell/splitmix:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"

S="${WORKDIR}/${MY_P}"

src_configure() {
	haskell-cabal_src_configure --flag=-base3 --flag=base4 \
		"$(cabal_flag template-haskell templatehaskell)"
}

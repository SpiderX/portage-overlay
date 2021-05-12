# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Stronger password hashing via sequential memory-hard functions"
HOMEPAGE="https://github.com/informatikr/scrypt"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/base64-bytestring:=[profile?]
	dev-haskell/entropy:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/hunit:=
		dev-haskell/quickcheck:2
		dev-haskell/test-framework:=
		dev-haskell/test-framework-hunit:=
		dev-haskell/test-framework-quickcheck2:= )"

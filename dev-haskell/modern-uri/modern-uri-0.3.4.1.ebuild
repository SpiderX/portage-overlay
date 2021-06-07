# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Modern library for working with URIs"
HOMEPAGE="https://github.com/mrkkrp/modern-uri"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="dev"

RDEPEND="dev-haskell/contravariant:=[profile?]
	dev-haskell/exceptions:=[profile?]
	dev-haskell/megaparsec:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/profunctors:=[profile?]
	dev-haskell/quickcheck:=[profile?]
	dev-haskell/reflection:=[profile?]
	dev-haskell/tagged:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/hspec:=
		dev-haskell/hspec-megaparsec:= )"

src_configure() {
	haskell-cabal_src_configure "$(cabal_flag dev dev)"
}

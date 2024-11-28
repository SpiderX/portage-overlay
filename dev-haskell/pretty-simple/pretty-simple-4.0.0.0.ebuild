# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Haskell data types that have a Show instance"
HOMEPAGE="https://github.com/cdepillabout/pretty-simple"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="buildexample buildexe"

RDEPEND=">=dev-haskell/prettyprinter-1.7.1:=[profile?]
	>=dev-haskell/prettyprinter-ansi-terminal-1.1.3:=[profile?]
	dev-lang/ghc:=
	buildexample? ( dev-haskell/aeson:=[profile?] )
	buildexe? ( dev-haskell/optparse-applicative:=[profile?] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	dev-haskell/cabal-doctest:=
	test? ( dev-haskell/doctest:=[profile?]
		dev-haskell/glob:=[profile?]
		dev-haskell/quickcheck:=[profile?] )"

GHC_BOOTSTRAP_PACKAGES=( cabal-doctest )

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' pretty-simple.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure \
		"$(cabal_flag buildexample buildexample)" \
		"$(cabal_flag buildexe buildexe)"
}

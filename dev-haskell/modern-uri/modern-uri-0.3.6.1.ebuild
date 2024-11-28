# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=2
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Modern library for working with URIs"
HOMEPAGE="https://github.com/mrkkrp/modern-uri"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="dev"

RDEPEND="dev-haskell/hashable:=[profile?]
	dev-haskell/megaparsec:=[profile?]
	dev-haskell/profunctors:=[profile?]
	dev-haskell/quickcheck:=[profile?]
	dev-haskell/reflection:=[profile?]
	dev-haskell/tagged:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/hspec:=[profile?]
		dev-haskell/hspec-megaparsec:=[profile?]
		dev-haskell/megaparsec:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' modern-uri.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure "$(cabal_flag dev dev)"
}

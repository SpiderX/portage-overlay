# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Testing JSON APIs with hspec-wai"
HOMEPAGE="https://github.com/hspec/hspec-wai"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/aeson-qq:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/hspec-wai:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec:=[profile?]
		dev-haskell/hspec-wai:=[profile?] )"

src_prepare() {
	default

	cabal_chdeps \
		'hspec-wai ==0.11.0' 'hspec-wai >=0.10.0'

	sed -i '/license-file/d' hspec-wai-json.cabal \
		|| die "sed failed"
}

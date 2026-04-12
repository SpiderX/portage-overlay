# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="A JUnit XML runner/formatter for hspec"
HOMEPAGE="https://github.com/freckle/hspec-junit-formatter"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/conduit:=[profile?]
	dev-haskell/hspec-api:=[profile?]
	dev-haskell/hspec-core:=[profile?]
	dev-haskell/iso8601-time:=[profile?]
	dev-haskell/regex-base:=[profile?]
	dev-haskell/regex-tdfa:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/xml-conduit:=[profile?]
	dev-haskell/xml-types:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec
		dev-haskell/hspec-golden
		dev-haskell/markdown-unlit
		dev-haskell/temporary )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' hspec-junit-formatter.cabal || die "sed failed"
}

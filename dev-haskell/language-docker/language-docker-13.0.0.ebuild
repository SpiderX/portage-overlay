# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Haskell Dockerfile parser, pretty-printer and EDSL"
HOMEPAGE="https://github.com/hadolint/language-docker"

LICENSE="GPL-3+"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/data-default:=[profile?]
	dev-haskell/data-default-class:=[profile?]
	dev-haskell/megaparsec:=[profile?]
	dev-haskell/prettyprinter:=[profile?]
	dev-haskell/split:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hunit:=[profile?]
		dev-haskell/hspec:=[profile?]
		dev-haskell/hspec-discover:=[profile?]
		dev-haskell/hspec-megaparsec:=[profile?]
		dev-haskell/quickcheck:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' language-docker.cabal || die "sed failed"
}

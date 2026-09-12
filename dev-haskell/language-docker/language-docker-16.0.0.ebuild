# Copyright 1999-2026 Gentoo Authors
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
	dev-haskell/text:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/hunit
		dev-haskell/hspec
		dev-haskell/hspec-megaparsec
		dev-haskell/quickcheck )"

CABAL_CHDEPS=(
	'megaparsec          >=9.7.0  && <9.9' 'megaparsec          >=9.5.0'
)

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' language-docker.cabal || die "sed failed"
}

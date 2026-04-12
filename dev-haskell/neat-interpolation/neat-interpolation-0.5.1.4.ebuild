# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Quasiquoter for neat and simple multiline text interpolation"
HOMEPAGE="https://github.com/nikita-volkov/neat-interpolation"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/megaparsec:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/rerebase
		dev-haskell/tasty
		dev-haskell/tasty-hunit )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' neat-interpolation.cabal || die "sed failed"
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="A fuzzy string set implementation in Haskell"
HOMEPAGE="https://github.com/laserpants/fuzzyset-haskell"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/data-default:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/text-metrics:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec:=
		dev-haskell/ieee754:= )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' fuzzyset.cabal || die "sed failed"
}

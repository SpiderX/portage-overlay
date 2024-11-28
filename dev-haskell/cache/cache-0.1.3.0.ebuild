# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=1
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="An in-memory key/value store with expiration support"
HOMEPAGE="https://github.com/hverr/haskell-cache"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/clock:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec:= )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' cache.cabal || die "sed failed"
}

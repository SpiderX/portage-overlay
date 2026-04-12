# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="ListT done right"
HOMEPAGE="https://github.com/nikita-volkov/list-t"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/foldl:=[profile?]
	dev-haskell/logict:=[profile?]
	dev-haskell/mmorph:=[profile?]
	dev-haskell/monad-control:=[profile?]
	dev-haskell/transformers-base:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/base-prelude
		dev-haskell/htf
		dev-haskell/mtl-prelude )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' list-t.cabal || die "sed failed"
}

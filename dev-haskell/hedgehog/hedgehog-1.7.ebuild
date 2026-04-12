# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=1
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Release with confidence"
HOMEPAGE="https://github.com/hedgehogqa/haskell-hedgehog"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/ansi-terminal:=[profile?]
	dev-haskell/async:=[profile?]
	dev-haskell/barbies:=[profile?]
	dev-haskell/concurrent-output:=[profile?]
	dev-haskell/erf:=[profile?]
	dev-haskell/lifted-async:=[profile?]
	dev-haskell/mmorph:=[profile?]
	dev-haskell/monad-control:=[profile?]
	dev-haskell/pretty-show:=[profile?]
	dev-haskell/primitive:=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/resourcet:=[profile?]
	dev-haskell/safe-exceptions:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/transformers-base:=[profile?]
	dev-haskell/wl-pprint-annotated:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/,+1d' hedgehog.cabal || die "sed failed"
}

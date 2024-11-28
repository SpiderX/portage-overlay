# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=6
CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Keyed functors and containers"
HOMEPAGE="https://github.com/ekmett/keys"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/comonad:=[profile?]
	dev-haskell/free:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/semigroupoids:=[profile?]
	dev-haskell/semigroups:=[profile?]
	dev-haskell/tagged:=[profile?]
	dev-haskell/transformers-compat:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' keys.cabal || die "sed failed"
}

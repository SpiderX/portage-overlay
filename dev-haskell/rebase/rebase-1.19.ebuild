# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="A more progressive alternative to the 'base' package"
HOMEPAGE="https://github.com/nikita-volkov/rebase"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/bifunctors:=[profile?]
	dev-haskell/comonad:=[profile?]
	dev-haskell/contravariant:=[profile?]
	dev-haskell/dlist:=[profile?]
	dev-haskell/either:=[profile?]
	dev-haskell/groups:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/invariant:=[profile?]
	dev-haskell/profunctors:=[profile?]
	dev-haskell/scientific:=[profile?]
	dev-haskell/selective:=[profile?]
	dev-haskell/semigroupoids:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/time-compat:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/uuid-types:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-haskell/vector-instances:=[profile?]
	dev-haskell/void:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	haskell-cabal_src_prepare
	cabal-mksetup
	sed -i '/license-file/d' rebase.cabal || die "sed failed"
}

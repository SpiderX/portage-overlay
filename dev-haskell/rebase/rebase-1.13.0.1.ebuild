# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="A more progressive alternative to the 'base' package"
HOMEPAGE="https://github.com/nikita-volkov/rebase"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/bifunctors:=[profile?]
	dev-haskell/comonad:=[profile?]
	dev-haskell/contravariant:=[profile?]
	dev-haskell/dlist:=[profile?]
	dev-haskell/either:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/hashable-time:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/profunctors:=[profile?]
	dev-haskell/scientific:=[profile?]
	>=dev-haskell/selective-0.4:=[profile?]
	dev-haskell/semigroupoids:=[profile?]
	dev-haskell/stm:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/uuid-types:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-haskell/vector-instances:=[profile?]
	dev-haskell/void:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	default

	cabal_chdeps \
		'hashable >=1.3 && <1.4' 'hashable >=1.2.7.0 && <1.4' \
		'profunctors >=5.6 && <5.7' 'profunctors >=5.5.1 && <5.7' \
		'unordered-containers >=0.2.13 && <0.3' 'unordered-containers >=0.2.12 && <0.3'

	sed -i '/license-file/d' rebase.cabal \
		|| die "sed failed"
}

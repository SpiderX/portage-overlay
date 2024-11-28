# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Additional Instances for Data.Vector"
HOMEPAGE="https://github.com/ekmett/vector-instances"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+hashable"

RDEPEND="dev-haskell/comonad:=[profile?]
	dev-haskell/keys:=[profile?]
	dev-haskell/pointed:=[profile?]
	dev-haskell/semigroupoids:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:=
	hashable? ( dev-haskell/hashable:=[profile?] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' vector-instances.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure \
		"$(cabal_flag hashable hashable)"
}

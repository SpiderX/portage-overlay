# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Pointed and copointed data"
HOMEPAGE="https://github.com/ekmett/pointed"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+comonad +kan-extensions +semigroupoids +stm +tagged +transformers +unordered-containers"

RDEPEND="dev-haskell/data-default-class:=[profile?]
	dev-lang/ghc:=
	comonad? ( dev-haskell/comonad:=[profile?] )
	kan-extensions? ( dev-haskell/kan-extensions:=[profile?] )
	semigroupoids? ( dev-haskell/semigroupoids:=[profile?] )
	tagged? ( dev-haskell/tagged:=[profile?] )
	transformers? ( dev-haskell/transformers-compat:=[profile?] )
	unordered-containers? ( dev-haskell/hashable:=[profile?]
				dev-haskell/unordered-containers:=[profile?] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' pointed.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure \
		--flag=containers \
		"$(cabal_flag comonad comonad)" \
		"$(cabal_flag kan-extensions kan-extensions)" \
		"$(cabal_flag semigroupoids semigroupoids)" \
		"$(cabal_flag stm stm)" \
		"$(cabal_flag tagged tagged)" \
		"$(cabal_flag transformers transformers)" \
		"$(cabal_flag unordered-containers unordered-containers)"
}

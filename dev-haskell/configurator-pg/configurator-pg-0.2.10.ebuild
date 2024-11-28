# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Reduced parser for configurator-ng config files"
HOMEPAGE="https://github.com/robx/configurator-pg"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/megaparsec:=[profile?]
	dev-haskell/protolude:=[profile?]
	dev-haskell/scientific:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hunit:=[profile?]
		dev-haskell/test-framework:=[profile?]
		dev-haskell/test-framework-hunit:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' configurator-pg.cabal || die "sed failed"
}

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="A Haskell web framework, using WAI and Warp"
HOMEPAGE="https://github.com/scotty-web/scotty"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="<dev-haskell/aeson-1.4:=[profile?]
	<dev-haskell/blaze-builder-0.5:=[profile?]
	<dev-haskell/case-insensitive-1.3:=[profile?]
	<dev-haskell/data-default-class-0.2:=[profile?]
	>=dev-haskell/exceptions-0.7:=[profile?] <dev-haskell/exceptions-0.11:=[profile?]
	dev-haskell/fail:=[profile?]
	<dev-haskell/http-types-0.13:=[profile?]
	>=dev-haskell/monad-control-1.0.1.0:=[profile?] <dev-haskell/monad-control-1.1:=[profile?]
	<dev-haskell/mtl-2.3:=[profile?]
	<dev-haskell/nats-2:=[profile?]
	>=dev-haskell/network-2.6.2.1:=[profile?] <dev-haskell/network-2.8:=[profile?]
	<dev-haskell/regex-compat-0.96:=[profile?]
	<dev-haskell/text-1.3:=[profile?]
	<dev-haskell/transformers-0.6:=[profile?]
	<dev-haskell/transformers-base-0.5:=[profile?]
	>=dev-haskell/transformers-compat-0.4.0.4:=[profile?] <dev-haskell/transformers-compat-0.7:=[profile?]
	>=dev-haskell/wai-3.0.3.0:=[profile?] <dev-haskell/wai-3.3:=[profile?]
	<dev-haskell/wai-extra-3.1:=[profile?]
	<dev-haskell/warp-3.3:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}
	dev-haskell/cabal:="

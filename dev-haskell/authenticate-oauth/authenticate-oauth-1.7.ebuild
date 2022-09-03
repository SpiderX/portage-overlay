# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Library to authenticate with OAuth for Haskell web applications"
HOMEPAGE="https://github.com/yesodweb/authenticate"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/base64-bytestring:=[profile?]
	dev-haskell/blaze-builder:=[profile?]
	dev-haskell/crypto-pubkey-types:=[profile?]
	dev-haskell/data-default:=[profile?]
	dev-haskell/http-client:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/rsa:=[profile?]
	dev-haskell/sha:=[profile?]
	dev-haskell/transformers-compat:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"

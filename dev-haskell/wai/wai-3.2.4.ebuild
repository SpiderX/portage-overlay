# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Web Application Interface"
HOMEPAGE="https://github.com/yesodweb/wai"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/http-types:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/vault:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec:=[profile?] )"

src_prepare() {
	default

	sed -i '/License-file/d' wai.cabal \
		|| die "sed failed"
}

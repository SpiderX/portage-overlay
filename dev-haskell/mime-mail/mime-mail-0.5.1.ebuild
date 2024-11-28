# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Compose MIME email messages"
HOMEPAGE="https://github.com/snoyberg/mime-mail"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/base64-bytestring:=[profile?]
	dev-haskell/blaze-builder:=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/hspec:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/License-file/d' mime-mail.cabal || die "sed failed"
}

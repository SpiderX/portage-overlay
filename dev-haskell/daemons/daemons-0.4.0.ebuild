# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Daemons in Haskell made fun and easy"
HOMEPAGE="https://github.com/scvalex/daemons"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/cereal:=[profile?]
	dev-haskell/data-default:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/pipes:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/hunit
		dev-haskell/test-framework
		dev-haskell/test-framework-hunit )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/License-file/d' daemons.cabal || die "sed failed"
}

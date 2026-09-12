# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Efficiently run periodic, on-demand actions"
HOMEPAGE="https://github.com/yesodweb/wai"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/hspec
		dev-haskell/hunit
		dev-haskell/retry )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' auto-update.cabal || die "sed failed"
}

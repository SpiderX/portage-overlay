# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Versatile logging framework"
HOMEPAGE="https://github.com/haskell-hvr/hslogger"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/network:=[profile?]
	dev-haskell/network-bsd:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/hunit )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' hslogger.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure --flag=-buildtests \
		--flag=network--gt-3_0_0 --flag=-test
}

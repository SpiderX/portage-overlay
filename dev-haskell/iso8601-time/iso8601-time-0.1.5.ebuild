# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Convert to/from the ISO 8601 time format"
HOMEPAGE="https://github.com/nh2/iso8601-time"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec
		dev-haskell/hunit )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' iso8601-time.cabal || die "sed failed"
}

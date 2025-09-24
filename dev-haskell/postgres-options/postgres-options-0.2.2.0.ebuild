# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="An Options type for PostgreSQL"
HOMEPAGE="https://github.com/jfischoff/postgres-options"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-haskell/generic-monoid:=[profile?]
	dev-haskell/split:=[profile?]
	dev-haskell/uri-bytestring:=[profile?]
	dev-lang/ghc:="
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' postgres-options.cabal || die "sed failed"
}

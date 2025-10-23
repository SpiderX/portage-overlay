# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="SPDX license expression language"
HOMEPAGE="https://github.com/phadej/spdx"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

CDEPEND="dev-haskell/cabal:="
RDEPEND="${CDEPEND}
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="${CDEPEND}
	test? ( dev-haskell/base-compat:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

DOCS=( {CHANGELOG,README}.md )

CABAL_CHDEPS=(
	'base-compat       ^>=0.10.5 || ^>=0.11.1 || ^>=0.12.1' 'base-compat >=0.12.1'
)

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' spdx.cabal || die "sed failed"
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=7
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Efficient time zone handling"
HOMEPAGE="https://github.com/ysangkok/haskell-tz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+template-haskell"

RDEPEND="dev-haskell/data-default:=[profile?]
	dev-haskell/tzdata:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/hunit:=[profile?]
		dev-haskell/quickcheck:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-hunit:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?]
		dev-haskell/tasty-th:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/License-File/d' tz.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure \
		"$(cabal_flag template-haskell template-haskell)"
}

# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=10
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
	dev-haskell/vector:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/hunit
		dev-haskell/quickcheck
		dev-haskell/tasty
		dev-haskell/tasty-hunit
		dev-haskell/tasty-quickcheck
		dev-haskell/tasty-th )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/License-File/d' tz.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure \
		"$(cabal_flag template-haskell template-haskell)"
}

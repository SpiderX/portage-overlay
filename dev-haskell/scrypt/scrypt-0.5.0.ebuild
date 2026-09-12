# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Stronger password hashing via sequential memory-hard functions"
HOMEPAGE="https://github.com/informatikr/scrypt"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/base64-bytestring:=[profile?]
	dev-haskell/entropy:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/hunit
		dev-haskell/quickcheck
		dev-haskell/test-framework
		dev-haskell/test-framework-hunit
		dev-haskell/test-framework-quickcheck2 )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' scrypt.cabal || die "sed failed"
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="AES and common modes using AES-NI when available"
HOMEPAGE="https://github.com/TomMD/cipher-aes128"
SRC_URI="${SRC_URI}
	https://github.com/TomMD/cipher-aes128/commit/4f30d283de04a65cde5aab4500dd7d7b409602d5.patch -> ${P}-ghc-9.2.patch"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # fails

RDEPEND="dev-haskell/cereal:=[profile?]
	dev-haskell/crypto-api:=[profile?]
	dev-haskell/tagged:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/crypto-api-tests:=[profile?]
		dev-haskell/test-framework:=[profile?] )"

PATCHES=( "${DISTDIR}/${P}"-ghc-9.2.patch )

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' cipher-aes128.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure "$(cabal_flag test test)"
}

src_test() {
	haskell-cabal_src_test
	./dist/build/aes128_test/aes128_test || die "tests failed"
}

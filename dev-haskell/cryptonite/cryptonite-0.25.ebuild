# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Cryptography Primitives sink"
HOMEPAGE="https://github.com/haskell-crypto/cryptonite"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+cpu-flags-x86-rdrand +cpu_flags_x86_aes cpu_flags_x86_sse cpu_flags_x86_sse4_1 +integer-gmp"

RDEPEND="dev-haskell/basement:=[profile?]
	>=dev-haskell/memory-0.14.18:=[profile?]
	dev-lang/ghc:=
	virtual/libc"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-hunit:=[profile?]
		dev-haskell/tasty-kat:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

src_configure() {
	haskell-cabal_src_configure --flag=-check_alignment \
		--flag=-old_toolchain_inliner --flag=support_deepseq \
		"$(cabal_flag integer-gmp integer-gmp)" \
		"$(cabal_flag cpu_flags_x86_aes support_aesni)" \
		"$(cabal_flag cpu_flags_x86_sse4_1 support_pclmuldq)" \
		"$(cabal_flag cpu-flags-x86-rdrand support_rdrand)" \
		"$(cabal_flag cpu_flags_x86_sse support_sse)"
}

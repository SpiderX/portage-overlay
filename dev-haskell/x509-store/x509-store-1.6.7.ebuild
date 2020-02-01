# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="X.509 collection accessing and storing methods"
HOMEPAGE="https://github.com/vincenthz/hs-certificate"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/asn1-encoding-0.9:=[profile?]
	>=dev-haskell/asn1-types-0.3:=[profile?]
	dev-haskell/cryptonite:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/pem:=[profile?]
	>=dev-haskell/x509-1.7.2:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-hunit:=[profile?] )"

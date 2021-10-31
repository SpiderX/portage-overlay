# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Encoders and decoders for the PostgreSQL's binary format"
HOMEPAGE="https://github.com/nikita-volkov/postgresql-binary"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND="dev-haskell/aeson:=[profile?]
	>=dev-haskell/base-prelude-1.4:=[profile?]
	>=dev-haskell/binary-parser-0.5.6:=[profile?]
	dev-haskell/bytestring-strict-builder:=[profile?]
	dev-haskell/loch-th:=[profile?]
	dev-haskell/network-ip:=[profile?]
	dev-haskell/placeholders:=[profile?]
	dev-haskell/scientific:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/uuid:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/conversion:=[profile?]
		dev-haskell/conversion-bytestring:=[profile?]
		dev-haskell/conversion-text:=[profile?]
		dev-haskell/json-ast:=[profile?]
		dev-haskell/postgresql-libpq:=[profile?]
		dev-haskell/quickcheck:2=[profile?]
		dev-haskell/quickcheck-instances:=[profile?]
		dev-haskell/rerebase:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-hunit:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

src_prepare() {
	default

	sed -i '/license-file/,+1d' postgresql-binary.cabal \
		|| die "sed failed"
}

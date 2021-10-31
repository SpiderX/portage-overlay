# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Abstraction over transactions for Hasql"
HOMEPAGE="https://github.com/nikita-volkov/hasql-transaction"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND="dev-haskell/bytestring-tree-builder:=[profile?]
	dev-haskell/contravariant:=[profile?]
	dev-haskell/contravariant-extras:=[profile?]
	dev-haskell/hasql:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/async:=[profile?]
		dev-haskell/rerebase:=[profile?] )"

src_prepare() {
	default

	cabal_chdeps \
		'bytestring-tree-builder >=0.2.7.8 && <0.3' 'bytestring-tree-builder >=0.2.7.5 && <0.3'

	sed -i '/license-file/d' hasql-transaction.cabal \
		|| die "sed failed"
}

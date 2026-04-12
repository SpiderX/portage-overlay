# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Lawful typeclasses for bidirectional conversion between types"
HOMEPAGE="https://github.com/nikita-volkov/lawful-conversions"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/hashable:=[profile?]
	dev-haskell/primitive:=[profile?]
	dev-haskell/profunctors:=[profile?]
	dev-haskell/quickcheck:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/uuid-types:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/quickcheck-instances
		dev-haskell/rebase
		dev-haskell/tasty
		dev-haskell/tasty-quickcheck )"

CABAL_CHDEPS=(
	'quickcheck-instances >=0.3.32 && <0.4' 'quickcheck-instances >=0.3.29.1 && <0.4'
	'tasty-quickcheck >=0.11 && <0.12' 'tasty-quickcheck >=0.10.2 && <0.12'
)

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' lawful-conversions.cabal || die "sed failed"
}

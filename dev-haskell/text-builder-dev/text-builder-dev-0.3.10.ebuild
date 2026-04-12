# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Edge of developments for text-builder"
HOMEPAGE="https://github.com/nikita-volkov/text-builder-dev"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/deferred-folds:=[profile?]
	dev-haskell/isomorphism-class:=[profile?]
	dev-haskell/lawful-conversions:=[profile?]
	dev-haskell/quickcheck:=[profile?]
	dev-haskell/quickcheck-instances:=[profile?]
	dev-haskell/split:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/base-compat
		dev-haskell/quickcheck-classes
		dev-haskell/rerebase
		dev-haskell/tasty
		dev-haskell/tasty-hunit
		dev-haskell/tasty-quickcheck )"

CABAL_CHDEPS=(
	'lawful-conversions >=0.1.4 && <0.2' 'lawful-conversions >=0.1.4 && <0.5'
	'time >=1.12 && <2' 'time >=1.11 && <2'
)

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' text-builder-dev.cabal || die "sed failed"
}

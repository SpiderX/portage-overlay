# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Abstractions for operations on pointers"
HOMEPAGE="https://github.com/nikita-volkov/ptr"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/contravariant:=[profile?]
	dev-haskell/profunctors:=[profile?]
	dev-haskell/strict-list:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/cereal:=[profile?]
		dev-haskell/quickcheck:=[profile?]
		dev-haskell/quickcheck-instances:=[profile?]
		dev-haskell/rerebase:=[profile?]
		dev-haskell/tasty:=[profile?]
		dev-haskell/tasty-hunit:=[profile?]
		dev-haskell/tasty-quickcheck:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	cabal-mksetup
	sed -i '/license-file/d' ptr.cabal || die "sed failed"
}

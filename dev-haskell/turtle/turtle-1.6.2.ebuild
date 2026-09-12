# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ABAL_HACKAGE_REVISION=3
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Shell programming, Haskell-style"
HOMEPAGE="https://hackage.haskell.org/package/turtle"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/ansi-wl-pprint:=[profile?]
	dev-haskell/async:=[profile?]
	dev-haskell/clock:=[profile?]
	dev-haskell/foldl:=[profile?]
	dev-haskell/hostname:=[profile?]
	dev-haskell/managed:=[profile?]
	dev-haskell/optional-args:=[profile?]
	dev-haskell/optparse-applicative:=[profile?]
	dev-haskell/streaming-commons:=[profile?]
	dev-haskell/temporary:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unix-compat:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/doctest
		dev-haskell/tasty
		dev-haskell/tasty-hunit )"

CABAL_CHDEPS=(
	'bytestring           >= 0.9.1.8 && < 0.12' 'bytestring           >= 0.9.1.8'
	'tasty >=1.4 && <1.5' 'tasty >=1.4'
	'text                 >= 1.0.0   && < 2.1' 'text                 >= 1.0.0'
)

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' turtle.cabal || die "sed failed"
}

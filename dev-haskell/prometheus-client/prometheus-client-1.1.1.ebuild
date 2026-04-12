# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=1
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Haskell client library for exposing prometheus.io metrics"
HOMEPAGE="https://github.com/fimad/prometheus-haskell"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/atomic-primops:=[profile?]
	dev-haskell/clock:=[profile?]
	dev-haskell/data-sketches:=[profile?]
	dev-haskell/primitive:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/transformers-compat:=[profile?]
	dev-haskell/utf8-string:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/doctest
		dev-haskell/hspec
		dev-haskell/quickcheck
		dev-haskell/random-shuffle )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' prometheus-client.cabal || die "sed failed"
}

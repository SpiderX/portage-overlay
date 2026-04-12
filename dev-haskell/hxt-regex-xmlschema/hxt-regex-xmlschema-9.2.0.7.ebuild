# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="A regular expression library for W3C XML Schema regular expressions"
HOMEPAGE="https://github.com/UweSchmidt/hxt"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="profile"

RDEPEND="dev-haskell/hxt-charproperties:=[profile?]
	dev-haskell/parsec:=[profile?]
	dev-haskell/text:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hunit )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' hxt-regex-xmlschema.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure "$(cabal_flag profile profile)"
}

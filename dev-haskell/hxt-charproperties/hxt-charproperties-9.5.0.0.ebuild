# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"

inherit haskell-cabal

DESCRIPTION="Character properties and classes for XML and Unicode"
HOMEPAGE="https://github.com/UweSchmidt/hxt"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="profile"

RDEPEND="dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:="

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' hxt-charproperties.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure "$(cabal_flag profile profile)"
}

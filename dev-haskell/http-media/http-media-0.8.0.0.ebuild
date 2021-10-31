# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Processing HTTP Content-Type and Accept headers"
HOMEPAGE="https://github.com/zmthy/http-media"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/case-insensitive:=[profile?]
	dev-haskell/utf8-string:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/quickcheck:2=[profile?]
		dev-haskell/test-framework:=[profile?]
		dev-haskell/test-framework-quickcheck2:=[profile?] )"

src_prepare() {
	default

	cabal_chdeps \
		'base             >= 4.7  && < 4.13' 'base             >= 4.7  && < 5'

	# Change base for test too
	sed  -i -e '/license-file/d' \
		-e '/base                       >= 4.7/s/4.13/5/' http-media.cabal \
		|| die "sed failed"
}

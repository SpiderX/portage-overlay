# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Parse and run JSONPath queries on Aeson documents"
HOMEPAGE="https://github.com/taimoorzaeem/aeson-jsonpath"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/parsec:=[profile?]
	dev-haskell/regex-tdfa:=[profile?]
	dev-haskell/scientific:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/vector:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/hspec )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' aeson-jsonpath.cabal || die "sed failed"
}

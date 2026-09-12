# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_HACKAGE_REVISION=1
CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit edo haskell-cabal

DESCRIPTION="Fast XML generation library"
HOMEPAGE="https://github.com/skogsbaer/xmlgen"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/blaze-builder:=[profile?]
	dev-haskell/text:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/hunit
		dev-haskell/hxt
		dev-haskell/quickcheck )"

PATCHES=( "${FILESDIR}/${PN}"-0.6.2.2-tests.patch )

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' xmlgen.cabal || die "sed failed"

	# tarball omits the golden XML files required by the test suite
	use test && edo cp "${FILESDIR}"/fixture/{1,2,3,4,5,xhtml}.xml test/
}

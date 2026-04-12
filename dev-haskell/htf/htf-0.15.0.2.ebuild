# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
CABAL_PN="HTF"

inherit edo haskell-cabal

DESCRIPTION="The Haskell Test Framework"
HOMEPAGE="https://github.com/skogsbaer/HTF"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # https://github.com/skogsbaer/HTF/issues/133

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/base64-bytestring:=[profile?]
	dev-haskell/cpphs:=[profile?]
	dev-haskell/diff:=[profile?]
	dev-haskell/haskell-src:=[profile?]
	dev-haskell/hunit:=[profile?]
	dev-haskell/lifted-base:=[profile?]
	dev-haskell/monad-control:=[profile?]
	dev-haskell/old-time:=[profile?]
	dev-haskell/quickcheck:=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/regex-compat:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-haskell/xmlgen:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	dev-haskell/cpphs:=
	test? ( dev-haskell/aeson-pretty:=[profile?]
		dev-haskell/temporary:=[profile?]
		dev-haskell/unordered-containers:=[profile?] )"

CABAL_TEST_REQUIRED_BINS=(
	htfpp
)

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' HTF.cabal || die "sed failed"
	edo chmod +x scripts/local-htfpp
}

src_compile() {
	#  first build only the library and executable
	use test && cabal-build "lib:${CABAL_PN}" "exe:htfpp"

	# build the rest counting of where the library and executable is
	LD_LIBRARY_PATH="${S}/dist/build${LD_LIBRARY_PATH+:}${LD_LIBRARY_PATH}" \
	PATH="${S}/dist/build/htfpp${PATH+:}${PATH}" \
	haskell-cabal_src_compile
}

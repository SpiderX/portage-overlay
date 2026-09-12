# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit edo haskell-cabal

DESCRIPTION="Test interactive Haskell examples"
HOMEPAGE="https://github.com/martijnbastiaan/doctest-parallel"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="dev-haskell/base-compat:=[profile?]
	dev-haskell/cabal:=[profile?]
	dev-haskell/code-page:=[profile?]
	dev-haskell/ghc-exactprint:=[profile?]
	dev-haskell/ghc-paths:=[profile?]
	dev-haskell/glob:=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/syb:=[profile?]
	dev-haskell/unordered-containers:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/hspec
		dev-haskell/hspec-core
		dev-haskell/hunit
		dev-haskell/mockery
		dev-haskell/quickcheck
		dev-haskell/setenv
		dev-haskell/silently
		dev-haskell/stringbuilder )"

PATCHES=( "${FILESDIR}/${PN}"-0.4.1-tests.patch )

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' doctest-parallel.cabal || die "sed failed"
}

src_test() {
	local pkgdb="${S}/dist/package.conf.inplace"

	# doctest-parallel spawns GHCi while running its tests.  Cabal's
	# internal spectests-modules library is registered as hidden, so expose
	# it in the in-place package database used only for the test phase.
	edo ghc-pkg --package-db="${pkgdb}" expose "z-${PN}-z-spectests-modules-${PV}"

	GHC_PACKAGE_PATH="${pkgdb}:" haskell-cabal_src_test
}

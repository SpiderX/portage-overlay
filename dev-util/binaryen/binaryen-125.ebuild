# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit cmake edo python-any-r1

MY_PV="version_${PV}"

DESCRIPTION="Optimizer and compiler/toolchain library for WebAssembly"
HOMEPAGE="https://github.com/WebAssembly/binaryen"
SRC_URI="https://github.com/WebAssembly/${PN}/archive/version_${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-cpp/gtest
		$(python_gen_any_dep 'dev-python/filecheck[${PYTHON_USEDEP}]
			dev-python/lit[${PYTHON_USEDEP}]') )"

PATCHES=( "${FILESDIR}/${PN}"-125-test-CMakeLists.patch )

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_prepare() {
	# no v8
	edo rm -rf test/lit/d8
	# filecheck: no such file or directory: '%s'
	edo rm -rf test/lit/help
	edo rm test/lit/fuzz-types.test

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS="$(usex test)"
		-DENABLE_WERROR=OFF
	)
	cmake_src_configure
}

src_test() {
	edo "${BUILD_DIR}"/bin/binaryen-unittests
	edo "${BUILD_DIR}"/bin/binaryen-lit "${MAKEOPTS}" -vv test/lit
}

# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib git-r3

DESCRIPTION="Provides a C/C++ reflection API for SPIR-V shader bytecode"
HOMEPAGE="https://github.com/KhronosGroup/SPIRV-Reflect"
EGIT_REPO_URI="https://github.com/KhronosGroup/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-cpp/gtest )"

PATCHES=( "${FILESDIR}/${PN}"-1.4.350.0-tests.patch )

multilib_src_configure() {
	local mycmakeargs=(
		-DSPIRV_REFLECT_EXECUTABLE="$(multilib_is_native_abi && echo ON || echo OFF)"
		-DSPIRV_REFLECT_BUILD_TESTS="$(multilib_native_usex test)"
		-DSPIRV_REFLECT_STATIC_LIB="$(usex static-libs)"
	)

	cmake_src_configure
}

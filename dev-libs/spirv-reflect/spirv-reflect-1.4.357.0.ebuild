# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib

MY_PN=SPIRV-Reflect
MY_PV="vulkan-sdk-${PV}"

DESCRIPTION="Provides a C/C++ reflection API for SPIR-V shader bytecode"
HOMEPAGE="https://github.com/KhronosGroup/SPIRV-Reflect"
SRC_URI="https://github.com/KhronosGroup/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

DEPEND="~dev-util/spirv-headers-${PV}"
BDEPEND="test? ( dev-cpp/gtest )"

PATCHES=( "${FILESDIR}/${PN}"-1.4.350.0-CMakeLists.patch
	"${FILESDIR}/${PN}"-1.4.350.0-tests.patch )

multilib_src_configure() {
	local mycmakeargs=(
		-DSPIRV_REFLECT_EXECUTABLE="$(multilib_is_native_abi && echo ON || echo OFF)"
		-DSPIRV_REFLECT_BUILD_TESTS="$(multilib_native_usex test)"
		-DSPIRV_REFLECT_STATIC_LIB="$(usex static-libs)"
	)

	cmake_src_configure
}

multilib_src_install() {
	cmake_src_install

	sed -e "s|@VERSION@|${PV}|g" -e "s|@LIBDIR@|$(get_libdir)|g" \
		"${FILESDIR}"/spirv-reflect.pc > "${T}"/spirv-reflect-"${ABI}".pc || die

	insinto /usr/"$(get_libdir)"/pkgconfig
	newins "${T}"/spirv-reflect-"${ABI}".pc spirv-reflect.pc
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_IN_SOURCE_BUILD="1"
EGIT_REPO_URI="https://chromium.googlesource.com/${PN}/${PN}.git"

inherit cmake edo git-r3

DESCRIPTION="Library for freeswitch yuv graphics manipulation"
HOMEPAGE="https://chromium.googlesource.com/libyuv/libyuv"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="media-libs/libjpeg-turbo:0="
BDEPEND="test? ( dev-cpp/gtest )"

src_prepare() {
	# cmake_minimum_required() should be called prior to
	# this top-level project(), do not install static, fix libdir,
	# install yuvconstants
	sed -i  -e '/CMAKE_MINIMUM_REQUIRED( VERSION 2.8.12 )/d' \
		-e '/PROJECT (/iCMAKE_MINIMUM_REQUIRED( VERSION 2.8.12 )' \
		-e "/DESTINATION/s| lib| $(get_libdir)|" \
		-e "/TARGETS \${ly_lib_static}/d" \
		-e "/INSTALL ( PROGRAMS/aINSTALL ( PROGRAMS \${CMAKE_BINARY_DIR}/yuvconstants                  DESTINATION bin )" \
		CMakeLists.txt || die "sed failed for CMakeLists.txt"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUNIT_TEST="$(usex test)"
	)

	cmake_src_configure
}

src_test() {
	edo ./libyuv_unittest
}

src_install() {
	cmake_src_install

	insinto /usr/"$(get_libdir)"/pkgconfig
	newins - libyuv.pc < <(sed -e "/Version/s|%%VERSION%%|${PV}|" \
				-e "/libdir/s|%%LIBDIR%%|"$(get_libdir)"|" \
				"${FILESDIR}"/libyuv.pc \
				|| die "sed failed for libyuv.pc.in" )
	insinto /usr/"$(get_libdir)"/cmake/libyuv
	doins "${FILESDIR}"/libyuv-config.cmake
}

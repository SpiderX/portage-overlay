# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://chromium.googlesource.com/${PN}/${PN}.git"

inherit cmake edo git-r3

DESCRIPTION="Library for freeswitch yuv graphics manipulation"
HOMEPAGE="https://chromium.googlesource.com/libyuv/libyuv"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="media-libs/libjpeg-turbo:0="
BDEPEND="test? ( dev-cpp/gtest )"

S="${WORKDIR}"

src_prepare() {
	# do not install static, fix libdir
	sed -i  -e "/DESTINATION/s| lib| $(get_libdir)|" \
		-e "/TARGETS \${ly_lib_static}/d" CMakeLists.txt \
		|| die "sed failed"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DTEST="$(usex test)"
	)

	cmake_src_configure
}

src_test() {
	edo "${S}"_build/libyuv_unittest
}

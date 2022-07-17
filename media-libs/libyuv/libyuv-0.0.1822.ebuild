# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake edo

COMMIT="d62ee21e6627888e84466b5a5ed15775582ac67b"
# Version bump :
# The stable libyuv version follows the chromium browser:
# https://chromereleases.googleblog.com/search/label/Desktop%20Update
# search for "The stable channel has been updated to" XX.X.XXXX.XXX
#  -> https://github.com/chromium/chromium/blob/87.0.4280.88/DEPS
#     -> 'src/third_party/libyuv': '6afd9becdf58822b1da6770598d8597c583ccfad'
# https://chromium.googlesource.com/libyuv/libyuv/+/6afd9becdf58822b1da6770598d8597c583ccfad/include/libyuv/version.h
#  -> #define LIBYUV_VERSION 1822

DESCRIPTION="Library for freeswitch yuv graphics manipulation"
HOMEPAGE="https://chromium.googlesource.com/libyuv/libyuv"
SRC_URI="https://chromium.googlesource.com/${PN}/${PN}.git/+archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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

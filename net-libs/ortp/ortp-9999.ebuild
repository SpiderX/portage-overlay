# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/BelledonneCommunications/${PN}.git"

inherit cmake git-r3

DESCRIPTION="Open Real-time Transport Protocol (RTP, RFC3550) stack"
HOMEPAGE="https://github.com/BelledonneCommunications/ortp"
SRC_URI=""

LICENSE="GPL-3"
KEYWORDS=""
SLOT="0"
IUSE="debug doc ntp-timestamp minimal static-libs test"
RESTRICT="!test? ( test )"

RDEPEND="net-libs/bctoolbox"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	doc? ( app-doc/doxygen )"

src_prepare() {
	# Fix path for datadir
	sed -i "/DESTINATION \"${CMAKE_INSTALL_DATADIR}/s|\${ORTP_DOC_VERSION}|${PV}|" \
		CMakeLists.txt || die "sed failed for CMakeLists.txt"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_DEBUG_LOGS="$(usex debug)"
		-DENABLE_DOC="$(usex doc)"
		-DENABLE_NTP_TIMESTAMP="$(usex ntp-timestamp)"
		-DENABLE_PERF="$(usex minimal)"
		-DENABLE_STATIC="$(usex static-libs ON OFF)"
		-DENABLE_TESTS="$(usex test ON OFF)"
	)

	cmake_src_configure
}

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"

inherit cmake

DESCRIPTION="C library of key-value data structures"
HOMEPAGE="https://github.com/rtbrick/libdict"
SRC_URI="https://github.com/rtbrick/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs test"

RESTRICT="!test? ( test )"
BDEPEND="test? ( dev-util/cunit )"

src_prepare() {
	# respect multilib
	sed -i  -e "/LIBRARY DESTINATION/s/lib/$(get_libdir)/" \
		-e "/ARCHIVE DESTINATION/s/lib/$(get_libdir)/" \
		CMakeLists.txt || die "sed failed for CMakeLists.txt"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DLIBDICT_STATIC="$(usex static-libs)"
		-DLIBDICT_TESTS="$(usex test)"
		-DLIBDICT_TOOLS="NO"
	)
	cmake_src_configure
}

# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR="emake"
EGIT_REPO_URI="https://github.com/rtbrick/${PN}.git"

inherit cmake git-r3

DESCRIPTION="C library of key-value data structures"
HOMEPAGE="https://github.com/rtbrick/libdict"
SRC_URI=""

LICENSE="BSD-2"
KEYWORDS=""
SLOT="0"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-util/cunit )"

src_prepare() {
	# Respect multilib
	sed -i  -e "/LIBRARY DESTINATION/s/lib/$(get_libdir)/" \
		-e "/ARCHIVE DESTINATION/s/lib/$(get_libdir)/" \
		CMakeLists.txt

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

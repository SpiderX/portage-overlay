# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/rtbrick/${PN}.git"

inherit cmake git-r3

DESCRIPTION="A tool to simulate thousands of PPPoE or IPoE subscribers"
HOMEPAGE="https://github.com/rtbrick/bngblaster"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="debug test"
RESTRICT="!test? ( test )"

RDEPEND="dev-libs/jansson
	dev-libs/libdict
	dev-libs/openssl:=
	sys-libs/ncurses:="

BDEPEND="test? ( dev-util/cmocka )"

src_prepare() {
	# Remove Werror, look for shared library, support tinfo, allow-multiple-definition
	sed -i -e '/target_compile_options/s/-Werror //' \
		-e '/find_library/s/libdict.a/libdict.so/' \
		-e '/find_library/aset(CURSES_NEED_NCURSES TRUE)' \
		-e '/target_link_libraries/ifind_package(Curses REQUIRED)' \
		-e '/target_link_libraries/s/curses/${CURSES_LIBRARIES}/' \
		-e '/target_link_libraries/s/m/m "-Wl,--allow-multiple-definition"/' \
		CMakeLists.txt || die "sed failed for CMakeLists.txt"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE="$(usex debug Debug Release)"
		-DBNGBLASTER_TESTS="$(usex test ON OFF)"
	)
	cmake_src_configure
}

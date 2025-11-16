# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A tool to simulate thousands of PPPoE or IPoE subscribers"
HOMEPAGE="https://github.com/rtbrick/bngblaster"
SRC_URI="https://github.com/rtbrick/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug test"
RESTRICT="!test? ( test )"

RDEPEND="dev-libs/jansson:0=
	dev-libs/libdict
	dev-libs/openssl:=
	sys-libs/ncurses:="
BDEPEND="test? ( dev-util/cmocka )"

src_prepare() {
	# use shared library
	sed -i -e '/find_library/s/libdict.a/libdict.so/' \
		CMakeLists.txt || die "sed failed for CMakeLists.txt"
	# keep flags separated
	sed -i '/CMAKE_C_FLAGS/s|"|" |' code/bngblaster/CMakeLists.txt \
		|| die "sed failed for bngblaster/CMakeLists.txt"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE="$(usex debug Debug Release)"
		-DBNGBLASTER_TESTS="$(usex test ON OFF)"
	)
	cmake_src_configure
}

src_install() {
	dolib.so "${S}"_build/code/bngblaster/liblwipco{re,ntribportunix}.so
	cmake_src_install
}

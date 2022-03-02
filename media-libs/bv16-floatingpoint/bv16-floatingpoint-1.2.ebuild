# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="BroadVoice 16 kbs codec"
HOMEPAGE="https://gitlab.linphone.org/BC/public/external/bv16-floatingpoint"
SRC_URI="https://gitlab.linphone.org/BC/public/external/${PN}/-/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="static-libs"

src_prepare() {
	# Fix lib install path
	sed -i "/LIBRARY DESTINATION/s/lib/\${CMAKE_INSTALL_FULL_LIBDIR}/" \
		CMakeLists.txt || die "sed failed for CMakeLists.txt"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_STATIC="$(usex static-libs)"
	)

	cmake_src_configure
}

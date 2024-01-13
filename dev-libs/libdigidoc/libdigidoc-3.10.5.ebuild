# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="DigiDoc digital signature library"
HOMEPAGE="https://github.com/open-eid/libdigidoc http://id.ee"
SRC_URI="https://github.com/open-eid/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc +utils"

RDEPEND="dev-libs/libxml2:2
	dev-libs/opensc
	dev-libs/openssl:0=
	sys-libs/zlib:0="
DEPEND="${RDEPEND}
	virtual/libiconv"
BDEPEND="dev-cpp/open-eid-cmake
	virtual/pkgconfig
	doc? ( app-text/doxygen )"

DOCS=( AUTHORS {README,RELEASE-NOTES}.md )

src_prepare() {
	default

	# specify path to modules
	sed -i '/CMAKE_MODULE_PATH/s|${CMAKE_SOURCE_DIR}/cmake/|/usr/share/cmake/open-eis/|' \
		CMakeLists.txt || die "sed failed for CMakeLists.txt"

	# fix version definition
	sed  -i -e '/^\tVERSION/s/MAJOR_VER/PROJECT_VERSION_MAJOR/' \
		-e '/^\tVERSION/s/MINOR_VER/PROJECT_VERSION_MINOR/' \
		-e '/^\tVERSION/s/RELEASE_VER/PROJECT_VERSION_PATCH/' \
		libdigidoc/CMakeLists.txt || die "sed failed for libdigidoc/CMakeLists.txt"

	cmake_src_prepare
}

src_configure() {
	# gentoo zlib macro name
	append-cppflags "-DOF=_Z_OF"

	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DDOXYGEN_FOUND="$(usex doc yes no)"
		-DBUILD_TOOLS="$(usex utils)"
	)
	cmake_src_configure
}

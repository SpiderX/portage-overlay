# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library for handling digitally signed documents"
HOMEPAGE="https://github.com/open-eid/libdigidocpp https://id.ee"
SRC_URI="https://github.com/open-eid/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc java test +utils"
RESTRICT="!test? ( test )"

RDEPEND="dev-libs/libxml2:2
	dev-libs/opensc:0=
	dev-libs/xmlsec:=[openssl]
	dev-libs/libxslt
	sys-libs/zlib:0=[minizip]
	java? ( virtual/jre:= )"
DEPEND="${RDEPEND}
	java? ( dev-lang/swig )"
BDEPEND="virtual/pkgconfig
	doc? ( app-text/doxygen )
	test? ( dev-libs/boost:= )"

DOCS=( AUTHORS {README,RELEASE-NOTES}.md )

src_prepare() {
	# failed to load "/var/lib/portage/home/.digidocpp/digidocpp.conf"
	sed -i '/add_test(NAME runtest/,+3d' test/CMakeLists.txt \
		|| die "sed failed for CMakeLists.txt"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TOOLS="$(usex utils)"
		-DCMAKE_DISABLE_FIND_PACKAGE_Doxygen="$(usex !doc)"
		-DCMAKE_DISABLE_FIND_PACKAGE_SWIG="$(usex java)"
	)
	cmake_src_configure
}

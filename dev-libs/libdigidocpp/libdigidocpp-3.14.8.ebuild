# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library for handling digitally signed documents"
HOMEPAGE="https://github.com/open-eid/libdigidocpp https://id.ee"
SRC_URI="https://github.com/open-eid/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD GPL-2 MIT OASIS-Open W3C ZLIB"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc java pdf test +utils"
RESTRICT="!test? ( test )"

RDEPEND="dev-libs/libdigidoc
	dev-libs/opensc
	dev-libs/openssl:0=
	dev-libs/xalan-c
	dev-libs/xerces-c
	dev-libs/xml-security-c
	sys-libs/zlib:0=[minizip]
	java? ( virtual/jre:= )
	pdf? ( virtual/podofo-build )"
DEPEND="${RDEPEND}
	java? ( dev-lang/swig )
	virtual/libiconv"
BDEPEND="dev-cpp/open-eid-cmake
	dev-cpp/xsd
	virtual/pkgconfig
	|| ( app-editors/vim-core dev-util/xxdi )
	doc? ( app-doc/doxygen )
	test? ( dev-libs/boost:= )"

DOCS=( AUTHORS {README,RELEASE-NOTES}.md )

src_prepare() {
	default

	# specify path to modules
	sed -i '/CMAKE_MODULE_PATH/s|${CMAKE_SOURCE_DIR}/cmake/|/usr/share/cmake/open-eis/|' \
		CMakeLists.txt || die "sed failed for CMakeLists.txt"

	if ! has_version app-editors/vim-core ; then
		sed -i -e '/COMMAND xxd/s:xxd -i \(${BASE}.crt\):xxdi.pl \1 >:' \
			src/CMakeLists.txt || die "sed for src/CMakeLists.txt failed"
	fi

	# remove bundled lib
	rm -rf src/minizip || die "rm failed"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DCMAKE_INSTALL_DOCDIR="share/doc/${PF}/html"
		-DBUILD_TOOLS="$(usex utils)"
		-DDOXYGEN_FOUND="$(usex doc yes no)"
		-DPODOFO_FOUND="$(usex pdf yes no)"
		-DSWIG_FOUND="$(usex java yes no)"
	)
	cmake_src_configure
}

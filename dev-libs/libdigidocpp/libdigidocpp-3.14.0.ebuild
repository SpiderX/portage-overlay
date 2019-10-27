# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/open-eid/cmake.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/${P}/cmake"

inherit cmake-utils flag-o-matic git-r3

DESCRIPTION="Library for handling digitally signed documents"
HOMEPAGE="https://github.com/open-eid/libdigidocpp https://id.ee"
SRC_URI="https://github.com/open-eid/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD GPL-2 OASIS-Open W3C ZLIB"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc java libressl pdf test +utils"

RDEPEND="dev-libs/libdigidoc
	dev-libs/opensc
	dev-libs/xerces-c
	dev-libs/xml-security-c
	sys-libs/zlib:0=[minizip]
	java? ( virtual/jre:= )
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
	pdf? ( virtual/podofo-build )"
DEPEND="${RDEPEND}
	java? ( dev-lang/swig )
	virtual/libiconv"
BDEPEND="dev-cpp/xsd
	virtual/pkgconfig
	|| ( app-editors/vim-core dev-util/xxdi )
	doc? ( app-doc/doxygen )
	test? ( dev-libs/boost:= )"

DOCS=( AUTHORS {README,RELEASE-NOTES}.md )

src_unpack() {
	default

	git-r3_fetch
	git-r3_checkout
}

src_prepare() {
	default

	if ! has_version app-editors/vim-core ; then
		sed -i -e '/COMMAND xxd/s:xxd -i \(${BASE}.crt\):xxdi.pl \1 >:' \
			src/CMakeLists.txt || die "sed for src/CMakeLists.txt failed"
	fi

	# remove bundled lib
	rm -rf src/minizip || die "rm failed"

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DCMAKE_INSTALL_DOCDIR="share/doc/${PF}/html"
		-DBUILD_TOOLS="$(usex utils)"
		"$(cmake-utils_use_find_package doc Doxygen)"
		"$(cmake-utils_use_find_package pdf PoDoFo)"
		"$(cmake-utils_use_find_package java SWIG)"
	)
	cmake-utils_src_configure
}

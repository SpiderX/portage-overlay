# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )

inherit cmake python-single-r1

DESCRIPTION="Library for handling digitally signed documents"
HOMEPAGE="https://github.com/open-eid/libdigidocpp https://id.ee"
SRC_URI="https://github.com/open-eid/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="csharp doc java python test +utils"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
RESTRICT="!test? ( test )"

RDEPEND="dev-libs/libxml2:2
	dev-libs/opensc:0=
	dev-libs/xmlsec:=[openssl]
	dev-libs/libxslt
	virtual/minizip:0=
	virtual/zlib:0=
	java? ( virtual/jre:= )
	python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	csharp? ( dev-lang/swig )
	doc? ( app-text/doxygen )
	java? ( dev-lang/swig virtual/jdk )
	python? ( dev-lang/swig )
	test? ( dev-libs/boost:= )"

PATCHES=( "${FILESDIR}/${PN}-4.5.1-optional-bindings.patch" )

DOCS=( AUTHORS {README,RELEASE-NOTES}.md )

src_prepare() {
	# failed to load "/var/lib/portage/home/.digidocpp/digidocpp.conf"
	sed -i '/add_test(NAME runtest/,+3d' test/CMakeLists.txt \
		|| die "sed failed for CMakeLists.txt"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_CSHARP="$(usex csharp)"
		-DBUILD_JAVA="$(usex java)"
		-DBUILD_PYTHON="$(usex python)"
		-DBUILD_TOOLS="$(usex utils)"
		-DCMAKE_DISABLE_FIND_PACKAGE_Doxygen="$(usex !doc)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	use python && python_optimize
}

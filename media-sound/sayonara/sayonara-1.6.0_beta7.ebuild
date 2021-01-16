# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg

MY_PN="${PN}-player"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Small, clear and fast Qt-based audio player"
HOMEPAGE="https://sayonara-player.com"
SRC_URI="https://gitlab.com/luciocarreras/${MY_PN}/-/archive/${MY_PV}/${MY_P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
RESTRICT="test" # fails

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	dev-libs/glib:2
	media-libs/taglib
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	media-plugins/gst-plugins-soundtouch:1.0
	media-libs/libmtp
	sys-libs/zlib:0="
DEPEND="${RDEPEND}
	dev-qt/qtsvg:5
	test? ( dev-qt/qttest:5 )"
BDEPEND="dev-qt/linguist-tools:5
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# wrt 709450
	sed -i  -e '/execute_process(COMMAND gzip/d' \
		-e '/install(FILES/s/sayonara.1.gz/sayonara.1/' \
		resources/CMakeLists.txt || die "sed failed for resources/CMakeLists.txt"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_COTIRE="OFF"
		-DWITH_DOC="$(usex doc)"
		-DWITH_SYSTEM_TAGLIB="ON"
		-DWITH_TESTS="$(usex test)"
	)
	cmake_src_configure
}

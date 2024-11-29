# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.com/luciocarreras/sayonara-player.git"

inherit cmake git-r3 virtualx xdg

DESCRIPTION="Small, clear and fast Qt-based audio player"
HOMEPAGE="https://sayonara-player.com"

LICENSE="GPL-3+"
SLOT="0"
IUSE="doc test"
RESTRICT="!test? ( test )"

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
	media-libs/libmtp:0=
	sys-libs/zlib:0="
DEPEND="${RDEPEND}
	dev-qt/qtsvg:5
	test? ( dev-qt/qttest:5 )"
BDEPEND="dev-qt/linguist-tools:5
	virtual/pkgconfig
	doc? ( app-text/doxygen )"

src_prepare() {
	# wrt 709450
	sed -i  -e '/execute_process(COMMAND gzip/d' \
		-e '/install(FILES/s/sayonara.1.gz/sayonara.1/' \
		-e '/install(FILES/s/sayonara-ctl.1.gz/sayonara-ctl.1/' \
		-e '/install(FILES/s/sayonara-query.1.gz/sayonara-query.1/' \
		resources/CMakeLists.txt || die "sed failed for resources/CMakeLists.txt"

	# remove tests with temp path failed in sandbox
	sed -i  -e '/testTempPath/,+5d' \
		-e '/coverTempDirectory/d' \
		test/Util/StandardPathTest.cpp || die "sed failed for StandardPathTest.cpp"

	# remove deprecated category
	sed -i '/Categories/s|Application;||' resources/com.sayonara-player.Sayonara.desktop \
		|| die "sed failed for com.sayonara-player.Sayonara.desktop"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_COTIRE="OFF"
		-DWITH_DOC="$(usex doc)"
		-DWITH_TESTS="$(usex test)"
	)
	cmake_src_configure
}

src_test() {
	virtx cmake_src_test
}

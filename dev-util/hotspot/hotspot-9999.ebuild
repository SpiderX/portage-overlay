# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/KDAB/${PN}.git"

inherit cmake desktop git-r3 xdg

DESCRIPTION="Linux perf GUI for performance analysis"
HOMEPAGE="https://github.com/KDAB/hotspot"
SRC_URI=""

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="test"
RESTRICT="test" # fails

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	kde-frameworks/extra-cmake-modules
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kio:5
	kde-frameworks/kitemmodels:5
	kde-frameworks/kitemviews:5
	kde-frameworks/kwindowsystem:5
	kde-frameworks/solid:5
	kde-frameworks/threadweaver:5
	dev-util/perf
	virtual/libelf:="
DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:5 )"

src_prepare() {
	if ! use test ; then
		sed -i '/add_subdirectory(tests)/d' CMakeLists.txt \
			|| die "sed failed for CMakeLists.txt"
	fi

	cmake_src_prepare
}

src_install() {
	cmake_src_install

	domenu hotspot.desktop
	insinto /usr/share/metainfo
	doins com.kdab.Hotspot.appdata.xml
}

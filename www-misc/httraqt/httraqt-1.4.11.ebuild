# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Graphical user interface for HTTrack library, developed in C++ and based on Qt"
HOMEPAGE="https://httraqt.sourceforge.net"
SRC_URI="https://downloads.sourceforge.net/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug profile"
RESTRICT="mirror"

RDEPEND="dev-qt/qtbase:6[dbus,gui,widgets]
	dev-qt/qtmultimedia:6
	www-client/httrack"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/qttools:6[linguist]
	virtual/pkgconfig"

src_prepare() {
	sed -i '/Icon/s|.xpm||' desktop/httraqt.desktop || die "sed failed for desktop"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_DEBUGGER="$(usex debug)"
		-DUSE_PROFILER="$(usex profile)"
		-DUSE_QT_VERSION=6
	)
	cmake_src_configure
}

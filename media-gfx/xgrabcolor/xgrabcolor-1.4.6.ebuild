# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils desktop xdg-utils

DESCRIPTION="Qt-based basic color picker"
HOMEPAGE="http://hugo.pereira.free.fr/software/index.php"
SRC_URI="http://hugo.pereira.free.fr/software/tgz/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5
	|| (
		dev-qt/qtgui:5[X(-)]
		dev-qt/qtgui:5[xcb(-)]
	)"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		"-DUSE_QT5=1"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	domenu xgrabcolor.desktop
	doicon xgrabcolor.png
	doicon -s 128 xgrabcolor.png
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

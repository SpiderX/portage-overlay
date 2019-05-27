# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop qmake-utils xdg-utils

DESCRIPTION="Practical and minimal image viewer"
HOMEPAGE="https://interversehq.com/qview https://github.com/jurplel/qView"
SRC_URI="https://github.com/jurplel/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://media.githubusercontent.com/media/jurplel/qView/master/dist/linux/hicolor/scalable/apps/qview.svg
	https://media.githubusercontent.com/media/jurplel/qView/master/dist/linux/hicolor/256x256/apps/qview.png -> qview_256x256.png
	https://media.githubusercontent.com/media/jurplel/qView/master/dist/linux/hicolor/128x128/apps/qview.png -> qview_128x128.png
	https://media.githubusercontent.com/media/jurplel/qView/master/dist/linux/hicolor/64x64/apps/qview.png -> qview_64x64.png
	https://media.githubusercontent.com/media/jurplel/qView/master/dist/linux/hicolor/32x32/apps/qview.png -> qview_32x32.png
	https://media.githubusercontent.com/media/jurplel/qView/master/dist/linux/hicolor/16x16/apps/qview.png -> qview_16x16.png"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	x11-misc/xdg-utils"
DEPEND="${RDEPEND}
	x11-themes/hicolor-icon-theme"

src_unpack() {
	default

	# Icons in dist is broken
	for size in 16x16 32x32 64x64 128x128 256x256 ; do
		cp "${DISTDIR}"/qview_"${size}".png \
			"${S}"/dist/linux/hicolor/"${size}"/apps/qview.png
	done
	cp "${DISTDIR}"/qview.svg \
		"${S}"/dist/linux/hicolor/scalable/apps/qview.svg
}

src_prepare() {
	default

	# Do not install license
	sed -i '/license.files/d' qView.pro \
		|| die "sed failed for qView.pro"
}

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
	einstalldocs
	dosym ../icons/hicolor/256x256/apps/qview.png \
		/usr/share/pixmaps/qview.png
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop git-r3

DESCRIPTION="Qt launcher GUI for XFreeRDP"
HOMEPAGE="https://github.com/zrax/qfreerdp"
EGIT_REPO_URI="https://github.com/zrax/${PN}.git"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5"
DEPEND="${RDEPEND}"

src_install() {
	domenu "${FILESDIR}"/qfreerdp.desktop
	doicon -s 64 "${FILESDIR}"/qfreerdp.png

	cmake_src_install
}

# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/zrax/${PN}.git"

inherit cmake desktop git-r3

DESCRIPTION="Qt launcher GUI for XFreeRDP"
HOMEPAGE="https://github.com/zrax/qfreerdp"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5"
DEPEND="${RDEPEND}"

src_install() {
	domenu "${FILESDIR}"/qfreerdp.desktop
	doicon -s 64 "${FILESDIR}"/qfreerdp.png

	cmake_src_install
}

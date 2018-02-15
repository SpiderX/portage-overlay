# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils desktop git-r3

DESCRIPTION="Qt launcher GUI for XFreeRDP"
HOMEPAGE="https://github.com/zrax/qfreerdp"
SRC_URI=""
EGIT_REPO_URI="https://github.com/zrax/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5"
DEPEND="${RDEPEND}"

src_install() {
	domenu "${FILESDIR}"/"${PN}".desktop
	doicon -s 64 "${FILESDIR}"/"${PN}".png

	cmake-utils_src_install
}

# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/dail8859/${PN}.git"

inherit git-r3 qmake-utils xdg

DESCRIPTION="A cross-platform reimplementation of Notepad++"
HOMEPAGE="https://github.com/dail8859/NotepadNext"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5"

src_configure() {
	eqmake5 src/NotepadNext.pro
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${ED}" install
}

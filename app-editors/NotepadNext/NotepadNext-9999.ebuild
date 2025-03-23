# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 qmake-utils xdg

DESCRIPTION="A cross-platform reimplementation of Notepad++"
HOMEPAGE="https://github.com/dail8859/NotepadNext"
EGIT_REPO_URI="https://github.com/dail8859/${PN}.git"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-qt/qtbase:6[gui,network,widgets]
	dev-qt/qt5compat:6"
BDEPEND="dev-qt/qttools:6"

src_configure() {
	eqmake6 src/NotepadNext.pro
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${ED}" install
}

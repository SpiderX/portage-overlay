# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 qmake-utils

DESCRIPTION="QML port of qtermwidget"
HOMEPAGE="https://github.com/Swordfish90/qmltermwidget"
EGIT_REPO_URI="https://github.com/Swordfish90/${PN}.git"

LICENSE="BSD LGPL-2+"
SLOT="0"

RDEPEND="dev-qt/qtbase:6[gui,widgets]
	dev-qt/qtdeclarative:6"

src_configure() {
	eqmake6 PREFIX="${EPREFIX}/usr"
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${ED}" install
}

# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

COMMIT="8913504fa2ebd220ebe7c680c32954e1b3c035c5"

DESCRIPTION="QML port of qtermwidget"
HOMEPAGE="https://github.com/Swordfish90/qmltermwidget"
SRC_URI="https://github.com/Swordfish90/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qtbase:6[gui,widgets]
	dev-qt/qtdeclarative:6"

src_configure() {
	eqmake6 PREFIX="${EPREFIX}/usr"
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${ED}" install
}

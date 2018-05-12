# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="tremotesf2"

inherit gnome2-utils qmake-utils xdg-utils

DESCRIPTION="A remote GUI for transmission"
HOMEPAGE="https://github.com/equeim/tremotesf2"
SRC_URI="https://github.com/equeim/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	kde-frameworks/kwidgetsaddons:5"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

S="${WORKDIR}/${MY_PN}-${PV}"

DOCS=( CHANGELOG.md README.md )

src_configure() {
	eqmake5 PREFIX="${ED%/}"/usr
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

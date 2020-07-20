# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake gnome2-utils xdg

MY_PN="tremotesf2"

DESCRIPTION="A remote GUI for transmission"
HOMEPAGE="https://github.com/equeim/tremotesf2"
SRC_URI="https://github.com/equeim/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	kde-frameworks/kwidgetsaddons:5"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5
	dev-qt/qtconcurrent:5
	sys-devel/gettext"

S="${WORKDIR}/${MY_PN}-${PV}"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	cmake_src_prepare
}

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

DESCRIPTION="Plasma 6 applet in order to show window buttons in your panels"
HOMEPAGE="https://github.com/moodyhunter/applet-window-buttons6"
SRC_URI="https://github.com/moodyhunter/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="6"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qtbase:6[gui,widgets]
	dev-qt/qtdeclarative:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/kdeclarative:6
	kde-frameworks/ki18n:6
	kde-frameworks/kservice:6
	kde-frameworks/kpackage:6
	kde-frameworks/ksvg:6
	kde-plasma/plasma-workspace:6"

DOCS=( {CHANGELOG,README}.md )

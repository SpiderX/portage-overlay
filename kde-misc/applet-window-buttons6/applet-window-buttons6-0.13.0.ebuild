# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

DESCRIPTION="Plasma 6 applet in order to show window buttons in your panels"
HOMEPAGE="https://github.com/moodyhunter/applet-window-buttons6"
SRC_URI="https://github.com/moodyhunter/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="6"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	kde-frameworks/kcoreaddons:6
	kde-frameworks/kdeclarative:6
	kde-frameworks/ki18n:6
	kde-frameworks/kservice:6
	kde-frameworks/kpackage:6
	kde-frameworks/ksvg:6
	kde-plasma/plasma-workspace:6"
BDEPEND="kde-frameworks/extra-cmake-modules"

DOCS=( {CHANGELOG,README}.md )

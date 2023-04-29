# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/psifidotos/${PN}.git"

inherit ecm git-r3

DESCRIPTION="Plasma 5 applet in order to show window buttons in your panels"
HOMEPAGE="https://github.com/psifidotos/applet-window-buttons"
SRC_URI=""

LICENSE="GPL-2"
SLOT="5"
KEYWORDS=""

DEPEND="dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kdeclarative:5
	kde-plasma/kdecoration:5
	kde-frameworks/ki18n:5
	kde-frameworks/kservice
	kde-frameworks/kwindowsystem:5
	kde-frameworks/plasma:5"

DOCS=( {CHANGELOG,README}.md )

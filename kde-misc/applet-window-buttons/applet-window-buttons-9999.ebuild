# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/psifidotos/${PN}.git"

inherit ecm git-r3

DESCRIPTION="Plasma 5 applet in order to show window buttons in your panels"
HOMEPAGE="https://github.com/psifidotos/applet-window-buttons"

LICENSE="GPL-2"
SLOT="5"

RDEPEND="!kde-misc/applet-window-buttons6:6
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kdeclarative:5
	kde-plasma/kdecoration:6
	kde-frameworks/ki18n:5
	kde-frameworks/kservice
	kde-frameworks/kwindowsystem:5
	kde-plasma/plasma-workspace:6"

DOCS=( {CHANGELOG,README}.md )

PATCHES=( "${FILESDIR}"/"${PN}"-0.11.1-support-modern-plasma.patch )

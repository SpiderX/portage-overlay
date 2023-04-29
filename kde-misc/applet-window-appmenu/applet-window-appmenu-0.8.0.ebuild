# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

DESCRIPTION="Plasma 5 applet in order to show window appmenu in your panels"
HOMEPAGE="https://github.com/psifidotos/applet-window-appmenu"
SRC_URI="https://github.com/psifidotos/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	kde-frameworks/kconfigwidgets:5
	kde-plasma/kdecoration:5
	kde-frameworks/kwayland:5
	kde-frameworks/kwindowsystem:5
	kde-frameworks/plasma:5
	kde-plasma/plasma-workspace:5
	x11-libs/libSM
	x11-libs/libxcb
	x11-libs/libXrandr"

DOCS=( {CHANGELOG,README}.md )

# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/Luwx/${PN^}.git"

inherit ecm git-r3

DESCRIPTION="KDE theme style with aim to be visually modern and minimalistic"
HOMEPAGE="https://github.com/Luwx/Lightly"
SRC_URI=""

LICENSE="GPL-2"
SLOT="5"
KEYWORDS=""

DEPEND="dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	kde-frameworks/frameworkintegration:5
	kde-frameworks/kcmutils:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/ki18n:5
	kde-frameworks/kiconthemes:5
	kde-frameworks/kguiaddons:5
	kde-frameworks/kwayland:5
	kde-frameworks/kwindowsystem:5
	kde-frameworks/plasma:5
	kde-plasma/kdecoration:5
	x11-libs/libxcb:0="

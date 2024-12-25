# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/xuzhao9/${PN^}.git"

inherit ecm git-r3

DESCRIPTION="KDE theme style with aim to be visually modern and minimalistic"
HOMEPAGE="https://github.com/xuzhao9/Lightly"

LICENSE="GPL-2"
SLOT="6"

DEPEND="dev-qt/qtdbus:5
	dev-qt/qtdeclarative:6
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	kde-frameworks/frameworkintegration:6
	kde-frameworks/kcmutils:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/kconfigwidgets:6
	kde-frameworks/ki18n:6
	kde-frameworks/kiconthemes:6
	kde-frameworks/kguiaddons:6
	kde-frameworks/kwindowsystem:6
	kde-plasma/kdecoration:6
	kde-plasma/kwayland:6
	kde-plasma/plasma-workspace:6
	x11-libs/libxcb:0="

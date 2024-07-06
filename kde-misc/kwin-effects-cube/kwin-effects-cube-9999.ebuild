# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/zzag/${PN}.git"

inherit ecm git-r3

DESCRIPTION="Desktop cube effect for kwin"
HOMEPAGE="https://github.com/zzag/kwin-effects-cube"

LICENSE="BSD GPL-2 GPL-3"
SLOT="5"

RDEPEND="!kde-plasma/kdeplasma-addons:6
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtquick3d:6
	dev-qt/qtquickcontrols2:5
	dev-qt/qtwidgets:5
	kde-frameworks/kconfig:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kglobalaccel:5
	kde-frameworks/ki18n:5
	kde-frameworks/kwindowsystem:5
	kde-frameworks/kxmlgui:5
	kde-plasma/kwin:5
	media-libs/libepoxy
	x11-libs/libxcb:="
DEPEND="${RDEPEND}"

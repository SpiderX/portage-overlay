# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/zzag/${PN}.git"

inherit ecm git-r3

DESCRIPTION="Sliding animation for notification windows"
HOMEPAGE="https://github.com/zzag/kwin-effects-sliding-notifications"

LICENSE="GPL-3+ MIT"
SLOT="5"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtnetwork:5
	dev-qt/qtgui:5
	kde-frameworks/kconfig:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kwindowsystem:5
	kde-plasma/kwin:5
	media-libs/libepoxy
	x11-libs/libxcb:="
DEPEND="${RDEPEND}"

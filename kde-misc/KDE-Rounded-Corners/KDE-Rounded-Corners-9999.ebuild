# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.25.0

inherit ecm git-r3

DESCRIPTION="Rounds the corners of your windows in KDE Plasma 5 and 6"
HOMEPAGE="https://github.com/matinlotfali/KDE-Rounded-Corners"
EGIT_REPO_URI="https://github.com/matinlotfali/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
IUSE="wayland"

RDEPEND="dev-qt/qtbase:6[dbus,gui,widgets]
	dev-qt/qtdeclarative:6
	kde-frameworks/kcmutils:6
	kde-frameworks/kconfigwidgets:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/ki18n:6
	media-libs/libepoxy
	sys-devel/gettext
	x11-libs/libxcb:0=
	wayland? ( kde-plasma/kwin:6 )
	!wayland? ( kde-plasma/kwin-x11:6 )"
BDEPEND="virtual/pkgconfig"

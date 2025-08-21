# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm git-r3

DESCRIPTION="Dynamic wallpaper plugin for KDE Plasma"
HOMEPAGE="https://github.com/zzag/plasma5-wallpapers-dynamic"
EGIT_REPO_URI="https://github.com/zzag/${PN}.git"

LICENSE="BSD GPL-3+ LGPL-3+ CC0-1.0 CC-BY-SA-4.0"
SLOT="6"

RDEPEND="dev-qt/qtbase:6[concurrent,dbus,gui,xml]
	dev-qt/qtdeclarative:6
	dev-qt/qtpositioning:6
	kde-frameworks/karchive:6
	kde-frameworks/kconfig:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/ki18n:6
	kde-frameworks/kpackage:6
	kde-plasma/plasma-workspace:6
	media-libs/libavif:=
	media-libs/libexif"
DEPEND="${RDEPEND}"

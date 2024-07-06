# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

DESCRIPTION="Dynamic wallpaper plugin for KDE Plasma"
HOMEPAGE="https://github.com/zzag/plasma5-wallpapers-dynamic"
SRC_URI="https://github.com/zzag/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD GPL-3+ LGPL-3+ CC0-1.0 CC-BY-SA-4.0"
SLOT="5"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtpositioning:5
	dev-qt/qtxml:5
	kde-frameworks/karchive:5
	kde-frameworks/kconfig:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kpackage:5
	kde-plasma/plasma-workspace:5
	media-libs/libavif:=
	media-libs/libexif"
DEPEND="${RDEPEND}"

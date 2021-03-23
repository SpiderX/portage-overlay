# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/g-fb/${PN}.git"

inherit cmake git-r3 xdg

DESCRIPTION="Video player built with Qt/QML on top of libmpv"
HOMEPAGE="https://github.com/g-fb/haruna"
SRC_URI=""

LICENSE="GPL-3"
KEYWORDS=""
SLOT="0"

RDEPEND="dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	kde-frameworks/breeze-icons:5
	kde-frameworks/kconfig:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kfilemetadata:5
	kde-frameworks/ki18n:5
	kde-frameworks/kiconthemes:5
	kde-frameworks/kio:5
	kde-apps/kio-extras:5
	kde-frameworks/kirigami:5
	kde-frameworks/kxmlgui:5
	kde-frameworks/qqc2-desktop-style:5
	media-video/mpv[libmpv]
	net-misc/youtube-dl"
DEPEND="${RDEPEND}"
BDEPEND="kde-frameworks/extra-cmake-modules:5
	sys-devel/gettext"

src_prepare() {
	cmake_src_prepare
	xdg_src_prepare
}

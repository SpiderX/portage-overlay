# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/agateau/${PN}.git"

inherit cmake-utils git-r3

DESCRIPTION="Color picker and contrast checker"
HOMEPAGE="https://github.com/agateau/colorpick"
SRC_URI=""

LICENSE="BSD-4"
KEYWORDS=""
SLOT="0"
IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	kde-frameworks/kguiaddons:5
	kde-frameworks/kwidgetsaddons:5"
DEPEND="${RDEPEND}"

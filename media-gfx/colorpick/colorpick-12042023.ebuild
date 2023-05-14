# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="e13ad607ca9b9e58ee6f6484131a1db0e6e02d31"

DESCRIPTION="Color picker and contrast checker"
HOMEPAGE="https://github.com/agateau/colorpick"
SRC_URI="https://github.com/agateau/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-4"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	kde-frameworks/kguiaddons:5
	kde-frameworks/kwidgetsaddons:5"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${COMMIT}"

# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/jakar/qt-heif-image-plugin.git"
MY_PN="${PN}-image-plugin"
MY_P="${MY_PN}-${PV}"

inherit cmake git-r3

DESCRIPTION="Qt plugin for HEIF images"
HOMEPAGE="https://github.com/jakar/qt-heif-image-plugin"
SRC_URI=""

LICENSE="LGPL-3+"
SLOT="0/${PV}"
KEYWORDS=""
IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	media-libs/libheif:="
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( {CHANGELOG,README}.md )

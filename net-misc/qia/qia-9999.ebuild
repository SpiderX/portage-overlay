# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="http://git.stg.codes/${PN}.git"

inherit cmake git-r3

DESCRIPTION="Authorization tool for Stargazer Billing System written in Qt"
HOMEPAGE="http://stg.codes"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="dev-db/sqlite:3
	dev-libs/boost[static-libs]
	dev-libs/openssl:0=
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwebkit:5"
RDEPEND="${DEPEND}
	app-arch/bzip2
	sys-libs/zlib
	dev-libs/expat"

src_configure() {
	if use debug; then
		CMAKE_BUILD_TYPE="Debug"
	fi

	cmake_src_configure
}

# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

MY_P="${P}-Source"

DESCRIPTION="Authorization tool for Stargazer Billing System written in Qt"
HOMEPAGE="http://stg.codes"
SRC_URI="http://stg.codes/attachments/download/6/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-db/sqlite:3
	dev-libs/boost:0=[static-libs]
	dev-libs/openssl:0=
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwebkit:5"
RDEPEND="${DEPEND}
	app-arch/bzip2
	sys-libs/zlib
	dev-libs/expat"

S="${WORKDIR}/${MY_P}"

src_configure() {
	if use debug; then
		CMAKE_BUILD_TYPE="Debug"
	fi

	cmake-src_configure
}

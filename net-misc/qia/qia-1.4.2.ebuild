# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit cmake-utils

DESCRIPTION="Authorization tool for Stargazer Billing System written in Qt"
HOMEPAGE="http://stg.codes/"
MY_P="${P}-Source"
SRC_URI="http://stg.codes/attachments/download/6/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"
S="${WORKDIR}/${MY_P}"

DEPEND="
	dev-db/sqlite:3
	dev-libs/openssl:0
	dev-libs/boost[static-libs]
	dev-qt/qtcore:4[ssl]
	dev-qt/qtgui:4
	dev-qt/qtwebkit:4
"
RDEPEND="
	${DEPEND}
	app-arch/bzip2
	sys-libs/zlib
	dev-libs/expat
"

src_prepare() {
	epatch_user
}

src_configure() {
	if use debug; then
		CMAKE_BUILD_TYPE="Debug"
	fi

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}

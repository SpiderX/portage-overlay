# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Authorization tool for Stargazer Billing System written in Qt"
HOMEPAGE="https://stg.codes"
EGIT_REPO_URI="https://git.stg.codes/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND="dev-db/sqlite:3
	dev-libs/boost:0=
	dev-libs/openssl:0=
	dev-qt/qtcore:5
	dev-qt/qtgui:5"
RDEPEND="${DEPEND}
	app-arch/bzip2
	virtual/zlib:0=
	dev-libs/expat"

src_prepare() {
	# remove WebKit reference
	sed -i '/find_package/s/ QtWebKit//' CMakeLists.txt \
		|| die "sed failed"

	cmake_src_prepare
}

src_configure() {
	use debug && CMAKE_BUILD_TYPE="Debug"

	cmake_src_configure
}

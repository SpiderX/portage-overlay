# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit cmake-utils user eutils

SRC_URI="https://github.com/open-eid/${PN}/releases/download/v${PV}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Smart card manager UI application"
HOMEPAGE="http://id.ee/"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="+qt5"

#	dev-qt/qtsingleapplication
DEPEND="
	sys-apps/pcsc-lite
	dev-libs/opensc
	dev-libs/openssl:0
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/linguist-tools:5
		dev-qt/qtwidgets:5
		dev-qt/qtnetwork:5
	)
	!qt5? (
		dev-qt/qtcore:4[ssl]
		dev-qt/qtgui:4
		dev-qt/qtwebkit:4
	)
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
	local mycmakeargs="
		${mycmakeargs}
		$(cmake-utils_use_find_package qt5 Qt5Widgets)
	"
	cmake-utils_src_configure
}

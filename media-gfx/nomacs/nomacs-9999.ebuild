# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/nomacs/nomacs.git"

inherit cmake git-r3 xdg-utils

DESCRIPTION="Qt-based image viewer"
HOMEPAGE="https://nomacs.org"
SRC_URI=""

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="debug heif +jpeg +opencv plugins raw tiff zip"

REQUIRED_USE="raw? ( opencv ) tiff? ( opencv )"

RDEPEND="dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5[jpeg?]
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	media-gfx/exiv2:=
	heif? ( media-libs/libheif:0= )
	opencv? ( >=media-libs/opencv-3.4:= )
	raw? ( media-libs/libraw:= )
	tiff? (
		dev-qt/qtimageformats:5
		media-libs/tiff:0
	)
	zip? ( dev-libs/quazip[qt5(+)] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/linguist-tools:5
	virtual/pkgconfig"

S="${WORKDIR}/${P}/ImageLounge"

DOCS=( src/changelog.txt )

src_unpack() {
	git-r3_src_unpack
	if use plugins ; then
		git clone https://github.com/nomacs/nomacs-plugins.git \
			"${S}"/plugins || die "git failed"
	fi
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_CODE_COV=OFF
		-DENABLE_QT_DEBUG="$(usex debug)"
		-DUSE_SYSTEM_LIBQPSD=OFF
		-DUSE_SYSTEM_QUAZIP=ON
		-DENABLE_PLUGINS=ON
		-DENABLE_TRANSLATIONS=ON
		-DENABLE_HEIF="$(usex heif)"
		-DENABLE_OPENCV="$(usex opencv)"
		-DENABLE_RAW="$(usex raw)"
		-DENABLE_TIFF="$(usex tiff)"
		-DENABLE_QUAZIP="$(usex zip)"
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}

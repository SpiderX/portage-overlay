# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Reliable MTP client with minimalistic UI"
HOMEPAGE="https://whoozle.github.io/android-file-transfer-linux/"
SRC_URI="https://github.com/whoozle/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug fuse +qt5 shared usb"

RDEPEND="sys-apps/file
	sys-libs/readline:0
	fuse? ( sys-fs/fuse:0 )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)
	usb? ( virtual/libusb:1 )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	qt5? ( dev-qt/linguist-tools:5 )"

DOCS=( {FAQ,README}.md )

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE="$(usex debug Debug Release)"
		-DBUILD_FUSE="$(usex fuse)"
		-DBUILD_QT_UI="$(usex qt5)"
		-DBUILD_SHARED_LIB="$(usex shared)"
		-DUSB_BACKEND_LIBUSB="$(usex usb)"
	)
	cmake_src_configure
}

src_install() {
	if use qt5 ; then
		insinto /usr/share/qt5/translations
		doins qt/translations/*.qm
	fi
	insinto
	use shared && dolib.so "${S}"_build/libmtp-ng.so

	cmake_src_install
}

pkg_postinst() {
	if use usb; then
		ewarn "You're using libusb, this is known to be broken:"
		ewarn "large memory consumption, violating kernel memory limits and bugs"
	fi
}

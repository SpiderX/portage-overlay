# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PLOCALES="ru"

inherit cmake-utils l10n qmake-utils

DESCRIPTION="Reliable MTP client with minimalistic UI"
HOMEPAGE="https://whoozle.github.io/android-file-transfer-linux/"
SRC_URI="https://github.com/whoozle/${PN}/archive/v${PV}.tar.gz"

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
DEPEND="${RDEPEND}
	virtual/pkgconfig
	qt5? ( dev-qt/linguist-tools:5 )"

DOCS=( FAQ.md README.md )

src_prepare() {
	default

	local lr
	lr="$(qt5_get_bindir)"/lrelease
	l10n_prepare() {
		$lr qt/translations/"${PN}"_"${1}".ts || die "lrelease ${1} failed"
	}
	l10n_find_plocales_changes qt/translations "${PN}"_ .ts
	l10n_for_each_locale_do l10n_prepare

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE="$(usex debug Debug Release)"
		-DBUILD_FUSE="$(usex fuse)"
		-DBUILD_QT_UI="$(usex qt5)"
		-DBUILD_SHARED_LIB="$(usex shared)"
		-DUSB_BACKEND_LIBUSB="$(usex usb)"
	)
	cmake-utils_src_configure
}

src_install() {
	if use qt5 ; then
		insinto /usr/share/qt5/translations
		doins qt/translations/*.qm
	fi
	use shared && dolib "${S}"_build/libmtp-ng.so

	cmake-utils_src_install
}

pkg_postinst() {
	if use usb; then
		ewarn "You're using libusb, this is known to be broken:"
		ewarn "large memory consumption, violating kernel memory limits and bugs"
	fi
}

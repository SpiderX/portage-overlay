# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLOCALES="de es fr gr nl"

inherit cmake plocale xdg

DESCRIPTION="qCheckGmail is a Qt/C++ multiple gmail account checker"
HOMEPAGE="https://github.com/butonche/qCheckGMail"
SRC_URI="https://github.com/butonche/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-crypt/lxqt-wallet
	dev-qt/qtbase:6[dbus,network,widgets]
	kde-frameworks/kconfig:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/ki18n:6
	kde-frameworks/knotifications:6
	kde-frameworks/kstatusnotifieritem:6"
BDEPEND="virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${PN}"-2.3.12-lxqt-wallet.patch )

DOCS=( 'USE INSTRUCTIONS' changelog README.md )

src_prepare() {
	my_rm_loc() {
		sed -i "/translations\.qm\/.*_${1^^}.qm/d" CMakeLists.txt || die "sed failed"
	}
	plocale_for_each_disabled_locale my_rm_loc

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DINTERNAL_LXQT_WALLET=false
		-DKF6=true
	)
	cmake_src_configure
}

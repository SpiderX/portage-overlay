# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/mhogomchungu/${PN}.git"

inherit cmake git-r3 xdg

DESCRIPTION="qCheckGmail is a Qt/C++ multiple gmail account checker"
HOMEPAGE="https://github.com/mhogomchungu/qCheckGMail"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="kwallet libsecret"

RDEPEND="dev-libs/libgcrypt:0=
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	kde-frameworks/kconfig:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/knotifications:5
	kde-frameworks/ki18n:5"
BDEPEND="virtual/pkgconfig"

DOCS=( 'USE INSTRUCTIONS' changelog README.md )

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DKF5=true
		-DNOKDESUPPORT="$(usex kwallet true false)"
		-DNOSECRETSUPPORT="$(usex libsecret true false)"
	)
	cmake_src_configure
}

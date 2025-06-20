# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLOCALES="ca de en es fr id it ja ko nb_NO nl pa_PK ru si ta tr uk zh_CN"
PLOCALE_BACKUP="en"

inherit cmake optfeature plocale xdg

DESCRIPTION="A homebrew lightweight image viewer"
HOMEPAGE="https://github.com/BLumia/pineapple-pictures"
SRC_URI="https://github.com/BLumia/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus"

RDEPEND="dev-qt/qtbase:6[dbus?,widgets]
	dev-qt/qtsvg:6
	media-gfx/exiv2:0="
BDEPEND="dev-qt/qttools:6[linguist]
	virtual/pkgconfig"

src_prepare() {
	my_rm_loc() {
		rm app/translations/PineapplePictures_"${1}".ts \
			|| die "rm failed for app/translations/PineapplePictures_${1}.ts"
	}
	plocale_for_each_disabled_locale my_rm_loc

	cmake_src_prepare
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update

	optfeature "XCF, EXR, PSD and other extra image format " kde-frameworks/kimageformats:6
}

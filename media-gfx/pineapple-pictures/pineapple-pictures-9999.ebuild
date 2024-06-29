# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/BLumia/${PN}.git"

inherit cmake git-r3 optfeature xdg

DESCRIPTION="A homebrew lightweight image viewer"
HOMEPAGE="https://github.com/BLumia/pineapple-pictures"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	media-gfx/exiv2:0="
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/linguist-tools:5
	virtual/pkgconfig"

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update

	optfeature "XCF, EXR, PSD and other extra image format " kde-frameworks/kimageformats
}

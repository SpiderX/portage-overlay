# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm git-r3

DESCRIPTION="Currently playing song and playback controls in Plasma 6"
HOMEPAGE="https://github.com/ccatterina/plasmusic-toolbar"
EGIT_REPO_URI="https://github.com/ccatterina/${PN}.git"

LICENSE="GPL-3"
SLOT="6"

RDEPEND="dev-qt/qt5compat:6
	dev-qt/qtdeclarative:6
	kde-frameworks/kcmutils:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/kdeclarative:6
	kde-frameworks/ki18n:6
	kde-frameworks/kiconthemes:6
	kde-frameworks/kirigami:6
	kde-frameworks/ksvg:6
	kde-plasma/plasma-workspace:6"

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/plasmusic-toolbar
	doins -r src/.
}

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/KangweiZhu/${PN}.git"

inherit ecm git-r3

DESCRIPTION="Lyrics for currently playing song in Plasma 6"
HOMEPAGE="https://github.com/KangweiZhu/plasmusic-toolbar"

LICENSE="GPL-3"
SLOT="6"

RDEPEND="kde-frameworks/kdeclarative:6
	kde-frameworks/ki18n:6
	kde-frameworks/kirigami:6
	kde-plasma/plasma-workspace:6"

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/lyrics-on-panel-plasma6
	doins -r contents metadata.json
}

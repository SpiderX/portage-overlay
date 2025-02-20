# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

COMMIT="5c15a23dfe18b7cecbee8eaca450873d03860bac"

DESCRIPTION="Lyrics for currently playing song in Plasma 6"
HOMEPAGE="https://github.com/KangweiZhu/plasmusic-toolbar"
SRC_URI="https://github.com/KangweiZhu/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
SLOT="6"
KEYWORDS="~amd64 ~x86"

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

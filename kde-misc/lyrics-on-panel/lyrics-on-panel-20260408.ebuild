# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.25.0

inherit ecm

COMMIT="c896a8dc0c17bfdccfb363f3b8daddcb1d5bc09a"

DESCRIPTION="Lyrics for currently playing song in Plasma 6"
HOMEPAGE="https://github.com/KangweiZhu/lyrics-on-panel"
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

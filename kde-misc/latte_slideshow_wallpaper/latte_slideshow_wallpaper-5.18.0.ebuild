# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

DESCRIPTION="Plasma 5 Wallpaper plugin that informs Latte about background"
HOMEPAGE="https://github.com/psifidotos/latte_slideshow_wallpaper"
SRC_URI="https://github.com/psifidotos/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS="~amd64 ~x86"

RDEPEND="kde-misc/latte-dock
	kde-plasma/plasma-desktop:5"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.latte.slideshow
	doins metadata.desktop
	doins -r contents
}

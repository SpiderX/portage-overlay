# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

DESCRIPTION="KDE Translator Widget"
HOMEPAGE="https://github.com/y4my4my4m/kde-translator-widget"
SRC_URI="https://github.com/y4my4my4m/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="6"
KEYWORDS="~amd64 ~x86"

RDEPEND="kde-frameworks/kdeclarative:6
	kde-frameworks/kirigami:6
	kde-plasma/plasma-workspace:6"

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/com.github.y4my4m.kde-translator-widget
	doins -r contents metadata.json
}

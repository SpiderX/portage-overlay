# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

COMMIT="504e6c293d1df20370e76be7cbdbc3c6fbb1ac1e"

DESCRIPTION="Plasma 6 applet shows window title and icon in your panels"
HOMEPAGE="https://github.com/moodyhunter/applet-window-title6"
SRC_URI="https://github.com/moodyhunter/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2"
SLOT="6"
KEYWORDS="~amd64 ~x86"

RDEPEND="!kde-misc/applet-window-title:5
	kde-frameworks/kdeclarative:6
	kde-frameworks/kirigami:6
	kde-plasma/plasma-workspace:6"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.windowtitle
	doins metadata.json
	doins -r contents
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/moodyhunter/${PN}.git"

inherit ecm git-r3

DESCRIPTION="Plasma 6 applet shows window title and icon in your panels"
HOMEPAGE="https://github.com/moodyhunter/applet-window-title6"

LICENSE="GPL-2"
SLOT="6"

RDEPEND="kde-frameworks/kdeclarative:6
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
	doins metadata.desktop
	doins -r contents
}

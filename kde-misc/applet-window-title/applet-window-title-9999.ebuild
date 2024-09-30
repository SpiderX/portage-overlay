# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/psifidotos/${PN}.git"

inherit ecm git-r3

DESCRIPTION="Plasma 5 applet shows window title and icon in your panels"
HOMEPAGE="https://github.com/psifidotos/applet-window-title"

LICENSE="GPL-2"
SLOT="5"

RDEPEND="!kde-misc/applet-window-title:6
	kde-frameworks/kdeclarative:5
	kde-frameworks/kirigami:5
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

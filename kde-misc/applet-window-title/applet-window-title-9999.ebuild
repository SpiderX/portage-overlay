# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/psifidotos/${PN}.git"

inherit ecm git-r3

DESCRIPTION="Plasma 5 applet shows window title and icon in your panels"
HOMEPAGE="https://github.com/psifidotos/applet-window-title"
SRC_URI=""

LICENSE="GPL-2"
SLOT="5"
KEYWORDS=""

RDEPEND="kde-frameworks/kdeclarative:5
	kde-frameworks/kirigami:5
	kde-plasma/plasma-workspace:5"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.latte.spacer
	doins metadata.desktop
	doins -r contents
}

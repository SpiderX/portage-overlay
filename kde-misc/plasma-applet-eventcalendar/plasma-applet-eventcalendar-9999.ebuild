# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/Zren/${PN}.git"

inherit ecm git-r3

DESCRIPTION="Plasmoid for a calendar and agenda with weather"
HOMEPAGE="https://github.com/Zren/plasma-applet-eventcalendar"
SRC_URI=""

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS=""

RDEPEND="dev-qt/qtgraphicaleffects:5
	kde-plasma/plasma-workspace:5"

DOCS=( {Changelog,ReadMe}.md )

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.plasma.eventcalendar
	doins package/metadata.desktop
	doins -r package/contents
}

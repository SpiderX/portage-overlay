# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/popov895/${PN}.git"

inherit ecm git-r3

DESCRIPTION="Plasma applet shows information about power management inhibition"
HOMEPAGE="https://github.com/popov895/pminhibition"
SRC_URI=""

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS=""

RDEPEND="kde-plasma/plasma-workspace:5"

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.plasma.pminhibition

	doins metadata.desktop
	doins -r contents
}

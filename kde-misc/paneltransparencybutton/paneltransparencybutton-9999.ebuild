# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm git-r3

DESCRIPTION="Enable/disable transparency for specific plasma panels"
HOMEPAGE="https://github.com/TheEssem/paneltransparencybutton"
EGIT_REPO_URI="https://github.com/TheEssem/${PN}.git"

LICENSE="GPL-2"
SLOT="6"

RDEPEND="kde-plasma/plasma-workspace:6"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.paneltransparencybutton
	doins metadata.json
	doins -r contents
}

# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="Compact system sensors monitor for the panel"
HOMEPAGE="https://github.com/Brov3r/SensWidget"
EGIT_REPO_URI="https://github.com/yassine20011/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-qt/qtdeclarative:6
	kde-frameworks/kirigami:6
	kde-plasma/libksysguard:6
	kde-plasma/ksystemstats:6
	kde-plasma/libplasma:6"

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.brov3r.senswidget
	doins -r {contents,metadata.json}
}

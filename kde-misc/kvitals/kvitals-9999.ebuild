# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3 optfeature

DESCRIPTION="Plasma 6 panel widget displays live system vitals"
HOMEPAGE="https://github.com/yassine20011/kvitals"
EGIT_REPO_URI="https://github.com/yassine20011/${PN}.git"

LICENSE="GPL-3"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

RDEPEND="dev-qt/qtdeclarative:6
	kde-frameworks/kcmutils:6
	kde-frameworks/kdeclarative:6
	kde-frameworks/kiconthemes:6
	kde-frameworks/kirigami:6
	kde-frameworks/kitemmodels:6
	kde-plasma/libksysguard:6
	kde-plasma/ksystemstats:6
	kde-plasma/libplasma:6
	kde-plasma/plasma5support:6"

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.plasma.kvitals
	doins -r {contents,metadata.json}
}

pkg_postinst() {
	optfeature "opening System Monitor from the widget" kde-plasma/plasma-systemmonitor
}

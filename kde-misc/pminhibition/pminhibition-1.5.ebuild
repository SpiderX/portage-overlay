# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

DESCRIPTION="Plasma applet shows information about power management inhibition"
HOMEPAGE="https://github.com/popov895/pminhibition"
SRC_URI="https://github.com/popov895/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS="~amd64 ~x86"

RDEPEND="kde-frameworks/plasma:5"

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

# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

DESCRIPTION="Plasma widget to monitor the power consumption of your battery"
HOMEPAGE="https://github.com/atul-g/plasma-power-monitor"
SRC_URI="https://github.com/atul-g/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS="~amd64 ~x86"

RDEPEND="kde-plasma/plasma-workspace:5"

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.powerMonitor

	doins package/metadata.desktop
	doins -r package/contents
}

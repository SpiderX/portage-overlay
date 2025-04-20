# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm git-r3

DESCRIPTION="KDE Plasma widget to monitor the CPU power consumption"
HOMEPAGE="https://github.com/kphanipavan/cpu-power-monitor"
EGIT_REPO_URI="https://github.com/magillos/${PN}.git"

LICENSE="GPL-3"
SLOT="6"

RDEPEND="kde-frameworks/kdeclarative:6
	kde-frameworks/ki18n:6
	kde-frameworks/kirigami:6
	kde-plasma/plasma5support:6
	kde-plasma/plasma-workspace:6"

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/boi.walle.cpuPowerMonitor
	doins -r package/.
}

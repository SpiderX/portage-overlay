# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

COMMIT="8a3eae097a9770a8c3c6e5e81a9d45413ef2463a"

DESCRIPTION="KDE Plasma widget to monitor the CPU power consumption"
HOMEPAGE="https://github.com/kphanipavan/cpu-power-monitor"
SRC_URI="https://github.com/kphanipavan/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
SLOT="6"
KEYWORDS="~amd64 ~x86"

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

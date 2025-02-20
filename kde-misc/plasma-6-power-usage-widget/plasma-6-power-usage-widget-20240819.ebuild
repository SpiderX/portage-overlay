# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

COMMIT="0c469126da36333933e3aa73e2d0d8f8071fe0c2"

DESCRIPTION="Plasma 6 compatibile widget showing power usage"
HOMEPAGE="https://github.com/magillos/Plasma-6-power-usage-widget"
SRC_URI="https://github.com/magillos/${PN^}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN^}-${COMMIT}"

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

	insinto /usr/share/plasma/plasmoids/org.kde.plasma.powerusage
	doins -r Power-Usage/.
}

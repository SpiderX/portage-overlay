# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

DESCRIPTION="KDE5 Plasma Weather Widget"
HOMEPAGE="https://github.com/rliwoch/plasmoid-wunderground-extended"
SRC_URI="https://github.com/rliwoch/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE="plasma-nm"

RDEPEND="dev-qt/qtgraphicaleffects:5
	kde-plasma/plasma-workspace:5
	plasma-nm? ( kde-plasma/plasma-nm:5 )"

src_prepare() {
	default

	if ! use plasma-nm ; then
		sed -i  -e '/org.kde.plasma.networkmanagement/d' \
			-e '/PlasmaNM.NetworkStatus/,+18d' \
			plasmoid/contents/ui/main.qml || die "sed failed"
	fi
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/com.github.rliwoch.plasmoid-wunderground-extended
	doins plasmoid/metadata.desktop
	doins -r plasmoid/contents
}

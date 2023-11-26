# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

COMMIT="45b583d77ee2553589d0eebe63483908803a9a3a"

DESCRIPTION="Plasma Menu Widget for KDE"
HOMEPAGE="https://github.com/Risu/Tiled-Quicklaunch"
SRC_URI="https://github.com/Risu/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS="~amd64 ~x86"

RDEPEND="kde-plasma/plasma-workspace:5"

S="${WORKDIR}/${PN}-${COMMIT}"

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/risu.tiled.quicklaunch

	doins metadata.desktop
	doins -r contents
}

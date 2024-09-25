# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

COMMIT="ccbe62f58b72931008a7b26c3e8ab92e2bc3a52c"

DESCRIPTION="Plasma widget for play ambient noise"
HOMEPAGE="https://github.com/m-pilia/plasma-applet-ambientnoise"
SRC_URI="https://github.com/m-pilia/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qtquickcontrols2:5
	kde-plasma/plasma-workspace:6"

S="${WORKDIR}/${PN}-${COMMIT}"

src_prepare() {
	cmake_src_prepare
}

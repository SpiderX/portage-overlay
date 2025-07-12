# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

COMMIT="382a8016089105fa2419d3d7ae133668af842414"
MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Plasmoid for translation using the mymemory translated api"
HOMEPAGE="https://github.com/zayronxio/Kde.mymemory.translator"
SRC_URI="https://github.com/zayronxio/${MY_PN}/archive/${COMMIT}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_PN^}-${COMMIT}"

LICENSE="MIT"
SLOT="6"
KEYWORDS="~amd64 ~x86"

RDEPEND="kde-frameworks/kdeclarative:6
	kde-frameworks/ki18n:6
	kde-plasma/plasma-workspace:6"

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/kde.mymemory.translator
	doins -r contents metadata.json
}

# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PV="$(ver_rs 3 - 4 .)"

DESCRIPTION="AirPods libreated from Apple's ecosystem"
HOMEPAGE="https://github.com/kavishdevar/librepods"
SRC_URI="https://github.com/kavishdevar/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}/linux"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qtbase:6[dbus,widgets]
	dev-qt/qtconnectivity:6[bluetooth]
	dev-qt/qtdeclarative:6[widgets]
	dev-qt/qtmultimedia:6[ffmpeg]"
DEPEND="dev-libs/openssl:="

PATCHES=( "${FILESDIR}/${PN}"-0.1.0_rc4-rename.patch )

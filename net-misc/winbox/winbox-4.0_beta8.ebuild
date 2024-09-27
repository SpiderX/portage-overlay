# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop multilib-build

DESCRIPTION="Standalone client for Mikrotik routers"
HOMEPAGE="https://mikrotik.com/"
SRC_URI="https://download.mikrotik.com/routeros/${PN}/${PV//_}/WinBox_Linux.zip -> ${P}.zip"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="app-arch/bzip2:=[${MULTILIB_USEDEP}]
	dev-libs/expat[${MULTILIB_USEDEP}]
	media-libs/fontconfig:1.0[${MULTILIB_USEDEP}]
	media-libs/freetype:2[${MULTILIB_USEDEP}]
	media-libs/libglvnd[${MULTILIB_USEDEP}]
	media-libs/libpng:=[${MULTILIB_USEDEP}]
	sys-libs/zlib:=[${MULTILIB_USEDEP}]
	x11-libs/libXau[${MULTILIB_USEDEP}]
	x11-libs/libXdmcp[${MULTILIB_USEDEP}]
	x11-libs/libxcb:=[${MULTILIB_USEDEP}]
	x11-libs/libxkbcommon[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-image[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-keysyms[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-renderutil[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-wm[${MULTILIB_USEDEP}]"
BDEPEND="app-arch/unzip"

QA_PRESTRIPPED="usr/bin/winbox"

src_install() {
	newbin WinBox winbox
	doicon assets/img/winbox.png
	doicon -s 1024 assets/img/winbox.png
	domenu "${FILESDIR}"/winbox.desktop
}

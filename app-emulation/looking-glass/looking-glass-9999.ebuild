# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="LookingGlass"
MY_PV="a10"
MY_P="${MY_PN}-${MY_PV}"

inherit eutils git-r3 toolchain-funcs

DESCRIPTION="A low latency KVM FrameRelay implementation for guests with VGA PCI Passthrough"
HOMEPAGE="https://looking-glass.hostfission.com https://github.com/gnif/LookingGlass/"
SRC_URI="host? ( https://github.com/gnif/${MY_PN}/releases/download/${MY_PV}/looking-glass-host-${MY_PV}.zip )"
EGIT_REPO_URI="https://github.com/gnif/${MY_PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+host libressl"

RDEPEND="dev-libs/libconfig:0=
	media-libs/fontconfig:1.0
	media-libs/libsdl2
	media-libs/sdl2-ttf
	x11-libs/libva:0=[opengl]
	virtual/glu
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )"
DEPEND="${RDEPEND}
	app-emulation/spice-protocol
	virtual/pkgconfig"

# https://looking-glass.hostfission.com/node/6
S="${WORKDIR}/${P}/client"

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	einstalldocs

	dobin bin/looking-glass-client

	if use host ; then
		insinto /usr/share/"${PN}"
		doins "${DISTDIR}"/looking-glass-host-"${MY_PV}".zip
	fi
}

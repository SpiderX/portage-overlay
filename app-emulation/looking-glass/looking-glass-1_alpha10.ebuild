# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="LookingGlass"
MY_PV="${PV//1_alpha/a}"
MY_P="${MY_PN}-${MY_PV}"

inherit eutils

DESCRIPTION="A low latency KVM FrameRelay implementation for guests with VGA PCI Passthrough"
HOMEPAGE="https://looking-glass.hostfission.com https://github.com/gnif/LookingGlass/"
SRC_URI="https://github.com/gnif/${MY_PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz
	host? ( https://github.com/gnif/${MY_PN}/releases/download/${MY_PV}/looking-glass-host-${MY_PV}.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+host debug libressl"

RDEPEND="media-libs/fontconfig:1.0
	media-libs/libsdl2
	media-libs/sdl2-ttf
	virtual/glu
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )"
DEPEND="${RDEPEND}
	app-emulation/spice-protocol
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}/client"

src_prepare() {
	default

	# Respect CFLAGS
	sed -i \
		-e '/CFLAGS  = /s|CFLAGS  =|CFLAGS +=|' \
		-e '/CFLAGS += -g/s/-O3 -std=gnu99 -march=native/-std=gnu99/' \
		Makefile || die "sed failed for CFLAGS"

	if ! use debug ; then
		sed -i \
			-e '/CFLAGS += /s|-g||' \
			-e '/CFLAGS += /s|-DDEBUG||' \
			Makefile || die "sed failed for debug"
	fi
}

src_install() {
	dobin bin/looking-glass-client

	if use host ; then
		insinto /usr/share/"${PN}"
		doins "${DISTDIR}"/looking-glass-host-"${MY_PV}".zip
	fi
}

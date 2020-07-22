# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="LookingGlass"
MY_PV="a11"
EGIT_REPO_URI="https://github.com/gnif/${MY_PN}.git"
EGIT_SUBMODULES=()

inherit cmake git-r3

DESCRIPTION="A low latency KVM FrameRelay implementation for guests with VGA PCI Passthrough"
HOMEPAGE="https://looking-glass.hostfission.com https://github.com/gnif/LookingGlass/"
SRC_URI="host? ( https://github.com/gnif/${MY_PN}/releases/download/${MY_PV}/looking-glass-host-${MY_PV}.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug +host"

RDEPEND="dev-libs/libconfig:0=
	dev-libs/nettle:=[gmp]
	media-libs/freetype:2
	media-libs/fontconfig:1.0
	media-libs/libsdl2
	media-libs/sdl2-ttf
	virtual/glu"
DEPEND="${RDEPEND}
	app-emulation/spice-protocol"
BDEPEND="virtual/pkgconfig"

CMAKE_USE_DIR="${S}"/client

src_prepare() {
	default

	# Respect FLAGS
	sed -i '/CMAKE_C_FLAGS/s/-O3 -march=native //' \
		client/CMakeLists.txt || die "sed failed for FLAGS"

	if ! use debug ; then
		sed -i '/CMAKE_C_FLAGS/s/-g //' \
		client/CMakeLists.txt || die "sed failed for debug"
	fi

	cmake_src_prepare
}

src_install() {
	einstalldocs

	dobin "${BUILD_DIR}"/looking-glass-client

	if use host ; then
		insinto /usr/share/"${PN}"
		doins "${DISTDIR}"/looking-glass-host-"${MY_PV}".zip
	fi
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="VDPAU driver with OpenGL/VAAPI backend"
HOMEPAGE="https://github.com/i-rinat/libvdpau-va-gl"
SRC_URI="https://github.com/i-rinat/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="system-vdpau"

RDEPEND="media-libs/libglvnd
	media-libs/libva:0=
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXext
	x11-libs/libXdmcp
	x11-libs/libXfixes
	x11-libs/libdrm
	x11-libs/libxcb:0=
	x11-libs/libvdpau
	virtual/opengl"
BDEPEND="virtual/pkgconfig"

DOCS=( ChangeLog README.md )

src_prepare() {
	use system-vdpau && eapply "${FILESDIR}/${PN}"-0.4.2-system-vdpau.patch
	cmake_src_prepare
}

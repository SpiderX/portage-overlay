# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/i-rinat/${PN}.git"

inherit cmake git-r3 xdg

DESCRIPTION="VDPAU driver with OpenGL/VAAPI backend"
HOMEPAGE="https://github.com/i-rinat/libvdpau-va-gl"

LICENSE="MIT"
SLOT="0"
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
	use system-vdpau && eapply "${FILESDIR}/${PN}"-9999-system-vdpau.patch
	cmake_src_prepare
}

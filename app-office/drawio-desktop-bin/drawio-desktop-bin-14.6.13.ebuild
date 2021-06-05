# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-bin/}"
MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop multilib-build pax-utils unpacker xdg

DESCRIPTION="Diagram drawing application built on web technology"
HOMEPAGE="https://github.com/jgraph/drawio-desktop"
SRC_URI="https://github.com/jgraph/${MY_PN}/releases/download/v${PV}/drawio-amd64-${PV}.deb"

LICENSE="Apache-2.0"
SLOT=0
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-atk:2[${MULTILIB_USEDEP}]
	app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	dev-libs/atk:0[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/mesa:0[${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	sys-apps/util-linux:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite:0[${MULTILIB_USEDEP}]
	x11-libs/libXcursor:0[${MULTILIB_USEDEP}]
	x11-libs/libXdamage:0[${MULTILIB_USEDEP}]
	x11-libs/libXext:0[${MULTILIB_USEDEP}]
	x11-libs/libXfixes:0[${MULTILIB_USEDEP}]
	x11-libs/libXi:0[${MULTILIB_USEDEP}]
	x11-libs/libXrandr:0[${MULTILIB_USEDEP}]
	x11-libs/libXrender:0[${MULTILIB_USEDEP}]
	x11-libs/libXScrnSaver:0[${MULTILIB_USEDEP}]
	x11-libs/libXtst:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]"

QA_PREBUILT="opt/drawio/drawio
	opt/drawio/libffmpeg.so
	opt/drawio/libEGL.so
	opt/drawio/libGLESv2.so
	opt/drawio/libvk_swiftshader.so
	opt/drawio/swiftshader/libEGL.so
	opt/drawio/swiftshader/libGLESv2.so"

S="${WORKDIR}"

src_install() {
	for size in 16x16 32x32 48x48 64x64 96x96 128x128 192x192 256x256 ; do
		doicon -s "${size%%x*}" usr/share/icons/hicolor/"${size}"/apps/drawio.png
	done
	dosym ../icons/hicolor/256x256/apps/drawio.png \
		/usr/share/pixmaps/drawio.png

	domenu usr/share/applications/drawio.desktop
	insinto /usr/share/mime/packages
	doins usr/share/mime/packages/drawio.xml

	insinto /opt/drawio
	doins -r opt/drawio/.
	fperms +x /opt/drawio/drawio /opt/drawio/chrome-sandbox \
		/opt/drawio/swiftshader/lib{EGL,GLESv2}.so \
		/opt/drawio/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/drawio/libvulkan.so.1

	echo "PATH=\"/opt/drawio/\"" > "${T}"/99drawio
	doenvd "${T}"/99drawio

	pax-mark -m "${ED}"/opt/drawio/drawio
}

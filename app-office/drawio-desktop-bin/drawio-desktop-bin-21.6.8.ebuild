# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop pax-utils unpacker xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Diagram drawing application built on web technology"
HOMEPAGE="https://github.com/jgraph/drawio-desktop"
SRC_URI="https://github.com/jgraph/${MY_PN}/releases/download/v${PV}/drawio-amd64-${PV}.deb"

LICENSE="Apache-2.0"
SLOT=0
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-core:2
	dev-libs/expat:0
	dev-libs/glib:2
	dev-libs/nspr:0
	dev-libs/nss:0
	media-libs/alsa-lib:0
	media-libs/mesa:0
	net-print/cups:0
	sys-apps/dbus:0
	x11-libs/cairo:0
	x11-libs/gtk+:3
	x11-libs/libdrm:0
	x11-libs/libX11:0
	x11-libs/libxcb:0/1.12
	x11-libs/libXcomposite:0
	x11-libs/libXcursor:0
	x11-libs/libXdamage:0
	x11-libs/libXext:0
	x11-libs/libXfixes:0
	x11-libs/libXi:0
	x11-libs/libXrandr:0
	x11-libs/libXrender:0
	x11-libs/pango:0"

QA_PREBUILT="opt/drawio/chrome_crashpad_handler
	opt/drawio/chrome-sandbox
	opt/drawio/drawio
	opt/drawio/libffmpeg.so
	opt/drawio/libEGL.so
	opt/drawio/libGLESv2.so
	opt/drawio/libvk_swiftshader.so
	opt/drawio/libvulkan.so.1"

S="${WORKDIR}"

src_install() {
	for size in 16 32 48 64 96 128 192 256 512 1024 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}x${size}"/apps/drawio.png
	done
	dosym ../icons/hicolor/512x512/apps/drawio.png \
		/usr/share/pixmaps/drawio.png

	domenu usr/share/applications/drawio.desktop
	insinto /usr/share/mime/packages
	doins usr/share/mime/packages/drawio.xml

	insinto /opt/drawio
	doins -r opt/drawio/.
	fperms +x /opt/drawio/drawio /opt/drawio/chrome{-sandbox,_crashpad_handler} \
		/opt/drawio/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/drawio/libvulkan.so.1

	dosym ../drawio/drawio opt/bin/drawio

	pax-mark -m "${ED}"/opt/drawio/drawio
}

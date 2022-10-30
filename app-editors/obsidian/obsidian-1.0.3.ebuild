# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop optfeature pax-utils unpacker xdg

DESCRIPTION="A knowledge base of plain text Markdown files"
HOMEPAGE="https://obsidian.md/"
SRC_URI="https://github.com/${PN}md/${PN}-releases/releases/download/v${PV}/${PN}_${PV}_amd64.deb"

LICENSE="Obsidian"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="appindicator"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-atk:2
	app-accessibility/at-spi2-core:2
	dev-libs/atk:0
	dev-libs/expat:0
	dev-libs/glib:2
	dev-libs/nspr:0
	dev-libs/nss:0
	media-libs/alsa-lib:0
	media-libs/fontconfig:1.0
	media-libs/mesa:0
	net-print/cups:0
	sys-apps/dbus:0
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libdrm:0
	x11-libs/libX11:0
	x11-libs/libxcb:0/1.12
	x11-libs/libXcomposite:0
	x11-libs/libXdamage:0
	x11-libs/libXext:0
	x11-libs/libXfixes:0
	x11-libs/libxkbcommon:0
	x11-libs/libXrandr:0
	x11-libs/libXrender:0
	x11-libs/pango:0
	appindicator? ( dev-libs/libappindicator:3 )"

QA_FLAGS_IGNORED="opt/Obsidian/resources/app.asar.unpacked/node_modules/vibrancy-win/binding.node
	opt/Obsidian/resources/app.asar.unpacked/node_modules/btime/binding.node
	opt/Obsidian/resources/app.asar.unpacked/node_modules/get-fonts/binding.node
	opt/Obsidian/libEGL.so
	opt/Obsidian/chrome_crashpad_handler
	opt/Obsidian/obsidian
	opt/Obsidian/libvk_swiftshader.so
	opt/Obsidian/chrome-sandbox
	opt/Obsidian/swiftshader/libEGL.so
	opt/Obsidian/swiftshader/libGLESv2.so
	opt/Obsidian/libGLESv2.so
	opt/Obsidian/libffmpeg.so
	opt/Obsidian/libvulkan.so.1"

S="${WORKDIR}"

src_install() {
	for size in 16 32 48 64 128 256 512 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}x${size}"/apps/obsidian.png
	done
	dosym ../icons/hicolor/512x512/apps/obsidian.png \
		/usr/share/pixmaps/obsidian.png

	domenu usr/share/applications/obsidian.desktop

	insinto /opt/Obsidian
	doins -r opt/Obsidian/.
	fperms +x /opt/Obsidian/chrome{-sandbox,_crashpad_handler} \
		/opt/Obsidian/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/Obsidian/libvulkan.so.1 /opt/Obsidian/obsidian \
		/opt/Obsidian/swiftshader/lib{EGL,GLESv2}.so \
		/opt/Obsidian/resources/obsidian.asar \
		/opt/Obsidian/resources/app.asar.unpacked/node_modules/{btime,get-fonts,vibrancy-win}/binding.node
	dosym ../Obsidian/obsidian opt/bin/obsidian

	pax-mark -m "${ED}"/opt/Obsidian/obsidian
}

pkg_postinst() {
	optfeature "storing passwords via gnome-keyring" app-crypt/libsecret

	xdg_pkg_postinst
}

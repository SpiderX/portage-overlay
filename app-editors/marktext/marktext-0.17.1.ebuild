# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop pax-utils unpacker xdg

DESCRIPTION="A simple and elegant open-source markdown editor"
HOMEPAGE="https://github.com/marktext/marktext"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${PN}-amd64.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="appindicator"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-atk:2
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret:0
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
	x11-libs/libxshmfence:0
	x11-libs/pango:0
	appindicator? ( dev-libs/libappindicator:3 )"

QA_PRESTRIPPED="opt/MarkText/chrome_crashpad_handler
	opt/MarkText/libvk_swiftshader.so
	opt/MarkText/resources/app.asar.unpacked/node_modules/vscode-ripgrep/bin/rg"

S="${WORKDIR}"

src_install() {
	for size in 16 32 48 64 128 256 512 1025 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}x${size}"/apps/marktext.png
	done
	dosym ../icons/hicolor/1025x1025/apps/marktext.png \
		/usr/share/pixmaps/marktext.png

	domenu usr/share/applications/marktext.desktop

	insinto /opt/MarkText
	doins -r opt/MarkText/.
	fperms +x /opt/MarkText/chrome{-sandbox,_crashpad_handler} \
		/opt/MarkText/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/MarkText/libvulkan.so.1 /opt/MarkText/marktext \
		/opt/MarkText/swiftshader/lib{EGL,GLESv2}.so \
		/opt/MarkText/resources/app.asar.unpacked/node_modules/@hfelix/spellchecker/build/Release/spellchecker.node \
		/opt/MarkText/resources/app.asar.unpacked/node_modules/ced/build/Release/ced.node \
		/opt/MarkText/resources/app.asar.unpacked/node_modules/cld/build/Release/cld.node \
		/opt/MarkText/resources/app.asar.unpacked/node_modules/fontmanager-redux/build/Release/fontmanager.node \
		/opt/MarkText/resources/app.asar.unpacked/node_modules/keyboard-layout/build/Release/keyboard-layout-manager.node \
		/opt/MarkText/resources/app.asar.unpacked/node_modules/keytar/build/Release/keytar.node \
		/opt/MarkText/resources/app.asar.unpacked/node_modules/native-keymap/build/Release/keymapping.node \
		/opt/MarkText/resources/app.asar.unpacked/node_modules/vscode-ripgrep/bin/rg

	dosym ../MarkText/marktext opt/bin/marktext

	pax-mark -m "${ED}"/opt/MarkText/marktext
}

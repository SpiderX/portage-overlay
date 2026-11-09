# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="de en-US es fr ja ko nl pt-BR pt-PT ru tr zh-CN zh-TW"
MULTILIB_COMPAT=( abi_x86_64 )

inherit chromium-2 desktop edo multilib-build pax-utils unpacker xdg

DESCRIPTION="A simple and elegant open-source markdown editor"
HOMEPAGE="https://github.com/marktext/marktext"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${PN}-linux-${PV}.deb"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64"
RESTRICT="bindist mirror splitdebug"

RDEPEND="app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/libffi:0[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	dev-libs/libpcre2:0[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/fontconfig:1.0[${MULTILIB_USEDEP}]
	media-libs/mesa:0[vulkan,${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	sys-apps/util-linux[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libdrm:0[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXau[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite:0[${MULTILIB_USEDEP}]
	x11-libs/libXdamage:0[${MULTILIB_USEDEP}]
	x11-libs/libXdmcp[${MULTILIB_USEDEP}]
	x11-libs/libXext:0[${MULTILIB_USEDEP}]
	x11-libs/libXfixes:0[${MULTILIB_USEDEP}]
	x11-libs/libxkbcommon:0[${MULTILIB_USEDEP}]
	x11-libs/libXrandr:0[${MULTILIB_USEDEP}]
	x11-libs/libxshmfence:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]
	virtual/zlib:0[${MULTILIB_USEDEP}]"

QA_PREBUILT="opt/MarkText/resources/app.asar.unpacked/node_modules/native-keymap/bin/linux-x64-146/native-keymap.node
	opt/MarkText/resources/app.asar.unpacked/node_modules/native-keymap/build/Release/keymapping.node
	opt/MarkText/resources/app.asar.unpacked/node_modules/keytar/build/Release/keytar.node
	opt/MarkText/resources/app.asar.unpacked/node_modules/@vscode/ripgrep-linux-x64/bin/rg
	opt/MarkText/resources/app.asar.unpacked/node_modules/ced/bin/linux-x64-146/ced.node
	opt/MarkText/resources/app.asar.unpacked/node_modules/ced/build/Release/ced.node
	opt/MarkText/libEGL.so
	opt/MarkText/marktext
	opt/MarkText/chrome_crashpad_handler
	opt/MarkText/libvk_swiftshader.so
	opt/MarkText/libGLESv2.so
	opt/MarkText/libffmpeg.so
	opt/MarkText/libvulkan.so.1"

src_prepare() {
	default
	edo pushd opt/MarkText/locales
	chromium_remove_language_paks
	edo popd

	edo rm opt/MarkText/LICENSE{.electron.txt,S.chromium.html}
}

src_install() {
	doicon -s 256 usr/share/icons/hicolor/256x256/apps/marktext.png
	dosym ../icons/hicolor/256x256/apps/marktext.png \
		/usr/share/pixmaps/marktext.png

	domenu usr/share/applications/marktext.desktop

	insinto /usr/share/mime/packages
	doins usr/share/mime/packages/marktext.xml

	insinto /opt/MarkText
	doins -r opt/MarkText/.
	fperms +x /opt/MarkText/chrome_crashpad_handler \
		/opt/MarkText/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/MarkText/libvulkan.so.1 /opt/MarkText/marktext

	dosym ../MarkText/marktext opt/bin/marktext

	pax-mark -m "${ED}"/opt/MarkText/marktext
}

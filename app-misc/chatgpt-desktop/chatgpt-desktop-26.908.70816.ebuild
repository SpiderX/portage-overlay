# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi
	fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro
	ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
MULTILIB_COMPAT=( abi_x86_64 )

inherit chromium-2 desktop edo multilib-build optfeature pax-utils unpacker xdg

DESCRIPTION="Desktop application for ChatGPT and Codex"
HOMEPAGE="https://chatgpt.com"
SRC_URI="https://persistent.oaistatic.com/codex-app-prod/linux/deb/pool/main/c/chatgpt/chatgpt_${PV}_amd64.deb"
S="${WORKDIR}"

LICENSE="OpenAI"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64 apparmor qt6 wayland"
RESTRICT="bindist mirror splitdebug"

RDEPEND="app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	dev-libs/wayland[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/mesa:0[${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	virtual/libudev[${MULTILIB_USEDEP}]
	virtual/libusb:1[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite:0[${MULTILIB_USEDEP}]
	x11-libs/libXdamage:0[${MULTILIB_USEDEP}]
	x11-libs/libXext:0[${MULTILIB_USEDEP}]
	x11-libs/libXfixes:0[${MULTILIB_USEDEP}]
	x11-libs/libxkbcommon:0[${MULTILIB_USEDEP}]
	x11-libs/libXrandr:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]
	apparmor? ( >=sec-policy/apparmor-profiles-4
		>=sys-apps/apparmor-4 )
	qt6? ( dev-qt/qtbase:6[gui,widgets] )"

QA_PREBUILT="opt/chatgpt/ChatGPT
	opt/chatgpt/browser_crashpad_handler
	opt/chatgpt/libEGL.so
	opt/chatgpt/libGLESv2.so
	opt/chatgpt/libqt6_shim.so
	opt/chatgpt/libvk_swiftshader.so
	opt/chatgpt/libvulkan.so.1
	opt/chatgpt/resources/rg
	opt/chatgpt/resources/codex
	opt/chatgpt/resources/codex-code-mode-host
	opt/chatgpt/resources/plugins/openai-bundled/plugins/chrome/node_modules/classic-level/prebuilds/linux-x64/classic-level.node
	opt/chatgpt/resources/plugins/openai-bundled/plugins/browser/node_modules/classic-level/prebuilds/linux-x64/classic-level.node
	opt/chatgpt/resources/app.asar.unpacked/node_modules/@parcel/watcher-linux-x64-glibc/watcher.node
	opt/chatgpt/resources/app.asar.unpacked/node_modules/@worklouder/device-kit-oai/node_modules/@worklouder/wl-device-kit/node_modules/serialport/node_modules/@serialport/bindings-cpp/prebuilds/linux-x64/node.napi.glibc.node
	opt/chatgpt/resources/app.asar.unpacked/node_modules/@worklouder/device-kit-oai/node_modules/@worklouder/wl-device-kit/node_modules/node-hid/prebuilds/HID_hidraw-linux-x64/node-napi-v4.node
	opt/chatgpt/resources/app.asar.unpacked/node_modules/@worklouder/device-kit-oai/node_modules/@worklouder/wl-device-kit/node_modules/node-hid/prebuilds/HID-linux-x64/node-napi-v4.node
	opt/chatgpt/resources/cua_node/lib/node_modules/@oai/cua/dist/lib/js/oai_js_browser/dist/skill/node_modules/classic-level/prebuilds/linux-x64/classic-level.node
	opt/chatgpt/resources/cua_node/lib/node_modules/classic-level/prebuilds/linux-x64/classic-level.node
	opt/chatgpt/resources/cua_node/lib/node_modules/@img/sharp-linux-x64/lib/sharp-linux-x64-0.35.4.node
	opt/chatgpt/resources/cua_node/lib/node_modules/@img/sharp-libvips-linux-x64/lib/libvips-cpp.so.8.18.6"

src_prepare() {
	default
	pushd usr/lib/chatgpt/locales || die "pushd failed"
	chromium_remove_language_paks
	popd || die "popd failed"

	edo rm usr/lib/chatgpt/LICENSES.chromium.html \
		usr/lib/chatgpt/libqt5_shim.so \
		usr/lib/chatgpt/codex-launcher
	use qt6 || edo rm usr/lib/chatgpt/libqt6_shim.so

	if use wayland ; then
		sed -i  -e '/Exec/s/%U/%U --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland/' \
			usr/share/applications/chatgpt.desktop || die "sed failed for wayland"
	fi
	if use apparmor ; then
		sed -i "s|/usr/lib/chatgpt/ChatGPT|/opt/${PN}/ChatGPT|" \
			etc/apparmor.d/chatgpt || die "sed failed for apparmor"
	fi
}

src_install() {
	doicon usr/share/pixmaps/chatgpt.png
	doicon -s 512 usr/share/pixmaps/chatgpt.png
	domenu usr/share/applications/chatgpt.desktop

	insinto /usr/share/metainfo
	doins usr/share/metainfo/com.openai.chatgpt.metainfo.xml

	insinto /opt
	edo cp -a usr/lib/chatgpt "${ED}"/opt

	dosym ../../opt/chatgpt/ChatGPT usr/bin/chatgpt
	pax-mark -m "${ED}"/opt/chatgpt/ChatGPT

	# remove unsupported ARM/Android and musl prebuilt binaries
	edo find "${ED}" -type f -path '*prebuilds/*' \( -path '*arm*' -o -path '*musl*' \) -delete

	if use apparmor ; then
		insinto /etc/apparmor.d
		doins etc/apparmor.d/chatgpt
	fi
}

pkg_postinst() {
	optfeature "storing passwords via Secret Service API provider" virtual/secret-service
	xdg_pkg_postinst
}

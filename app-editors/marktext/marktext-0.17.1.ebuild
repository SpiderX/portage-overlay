# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi fr
	gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru
	sk sl sr sv sw ta te th tr uk vi zh-CN zh-TW"
MULTILIB_COMPAT=( abi_x86_64 )

inherit chromium-2 desktop multilib-build pax-utils unpacker xdg

DESCRIPTION="A simple and elegant open-source markdown editor"
HOMEPAGE="https://github.com/marktext/marktext"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${PN}-amd64.deb"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64 suid"
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
	sys-libs/zlib:0[${MULTILIB_USEDEP}]
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
	x11-libs/pango:0[${MULTILIB_USEDEP}]"

QA_PRESTRIPPED="opt/MarkText/chrome_crashpad_handler
	opt/MarkText/libvk_swiftshader.so
	opt/MarkText/resources/app.asar.unpacked/node_modules/vscode-ripgrep/bin/rg"

pkg_pretend() {
	use suid || chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default
	pushd opt/MarkText/locales || die "pushd failed"
	chromium_remove_language_paks
	popd || die "popd failed"

	rm opt/MarkText/LICENSE{,.electron.txt,S.chromium.html} \
		|| die "rm licenses failed"

	if ! use suid ; then
		rm opt/MarkText/chrome-sandbox || die "rm failed"
	fi
}

src_install() {
	for size in 16 32 48 64 128 256 512 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}x${size}"/apps/marktext.png
	done
	dosym ../icons/hicolor/512x512/apps/marktext.png \
		/usr/share/pixmaps/marktext.png

	domenu usr/share/applications/marktext.desktop

	insinto /opt/MarkText
	doins -r opt/MarkText/.
	fperms +x /opt/MarkText/chrome_crashpad_handler \
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
	use suid && fperms u+s,+x /opt/MarkText/chrome-sandbox

	dosym ../MarkText/marktext opt/bin/marktext

	pax-mark -m "${ED}"/opt/MarkText/marktext
}

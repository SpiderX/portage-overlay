# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi
	fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro
	ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
MULTILIB_COMPAT=( abi_x86_64 )

inherit chromium-2 desktop multilib-build pax-utils unpacker xdg

DESCRIPTION="A knowledge base of plain text Markdown files"
HOMEPAGE="https://obsidian.md/"
SRC_URI="https://github.com/${PN}md/${PN}-releases/releases/download/v${PV}/${PN}_${PV}_amd64.deb"
S="${WORKDIR}"

LICENSE="Obsidian"
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
	media-libs/mesa:0[vulkan,${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	sys-apps/util-linux[${MULTILIB_USEDEP}]
	sys-libs/zlib:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libdrm:0[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/libXau[${MULTILIB_USEDEP}]
	x11-libs/libXdmcp[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite:0[${MULTILIB_USEDEP}]
	x11-libs/libXdamage:0[${MULTILIB_USEDEP}]
	x11-libs/libXext:0[${MULTILIB_USEDEP}]
	x11-libs/libXfixes:0[${MULTILIB_USEDEP}]
	x11-libs/libxkbcommon:0[${MULTILIB_USEDEP}]
	x11-libs/libXrandr:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]"

pkg_pretend() {
	use suid || chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default
	pushd opt/Obsidian/locales || die "pushd failed"
	chromium_remove_language_paks
	popd || die "popd failed"

	rm opt/Obsidian/LICENSE{.electron.txt,S.chromium.html} \
		|| die "rm licenses failed"

	if ! use suid ; then
		rm opt/Obsidian/chrome-sandbox || die "rm failed"
	fi
}

src_install() {
	for size in 16 32 48 64 128 256 512 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}x${size}"/apps/obsidian.png
	done
	dosym ../icons/hicolor/512x512/apps/obsidian.png \
		/usr/share/pixmaps/obsidian.png

	domenu usr/share/applications/obsidian.desktop

	insinto /opt/Obsidian
	doins -r opt/Obsidian/.
	fperms +x /opt/Obsidian/chrome_crashpad_handler \
		/opt/Obsidian/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/Obsidian/libvulkan.so.1 /opt/Obsidian/obsidian \
		/opt/Obsidian/resources/obsidian.asar \
		/opt/Obsidian/resources/app.asar.unpacked/node_modules/{btime,get-fonts}/binding.node
	use suid && fperms u+s,+x /opt/Obsidian/chrome-sandbox

	dosym ../Obsidian/obsidian opt/bin/obsidian

	pax-mark -m "${ED}"/opt/Obsidian/obsidian
}

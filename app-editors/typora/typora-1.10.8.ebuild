# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi
	fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro
	ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
MULTILIB_COMPAT=( abi_x86_64 )

inherit chromium-2 desktop multilib-build pax-utils unpacker xdg

DESCRIPTION="A minimal markdown editor and reader"
HOMEPAGE="https://typora.io"
SRC_URI="https://typora.io/linux/${PN}_${PV}_amd64.deb"
S="${WORKDIR}"

LICENSE="Typora"
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
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite:0[${MULTILIB_USEDEP}]
	x11-libs/libXdamage:0[${MULTILIB_USEDEP}]
	x11-libs/libXdmcp[${MULTILIB_USEDEP}]
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
	pushd usr/share/typora/locales || die "pushd failed"
	chromium_remove_language_paks
	popd || die "popd failed"

	if ! use suid ; then
		rm usr/share/typora/chrome-sandbox || die "rm failed"
	fi
}

src_install() {
	for size in 32 64 128 256 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}x${size}"/apps/typora.png
	done
	dosym ../icons/hicolor/256x256/apps/typora.png \
		/usr/share/pixmaps/typora.png

	domenu usr/share/applications/typora.desktop

	insinto /opt/Typora
	doins -r usr/share/typora/.
	fperms +x /opt/Typora/chrome_crashpad_handler \
		/opt/Typora/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/Typora/libvulkan.so.1 /opt/Typora/Typora \
		/opt/Typora/resources/node_modules/cld/build/Release/cld.node \
		/opt/Typora/resources/node_modules/vscode-ripgrep/bin/rg
	use suid && fperms u+s,+x /opt/Typora/chrome-sandbox

	dosym ../Typora/Typora opt/bin/typora

	pax-mark -m "${ED}"/opt/Typora/Typora
}

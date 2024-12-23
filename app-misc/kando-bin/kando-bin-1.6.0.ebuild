# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi
	fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro
	ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
MULTILIB_COMPAT=( abi_x86_64 )

inherit chromium-2 desktop multilib-build pax-utils rpm xdg

MY_PN="${PN/-bin/}"
MY_PV="${PV}-1"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="A pie menu for the desktop"
HOMEPAGE="https://github.com/kando-menu/kando"
SRC_URI="https://github.com/kando-menu/${MY_PN}/releases/download/v"${PV}"/${MY_P}.x86_64.rpm"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64 suid"
RESTRICT="bindist mirror splitdebug"

RDEPEND="app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	dev-libs/libpcre2:0[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/mesa:0[vulkan,${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
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

pkg_pretend() {
	use suid || chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default
	pushd usr/lib/kando/locales || die "pushd failed"
	chromium_remove_language_paks
	popd || die "popd failed"

	rm usr/lib/kando/LICENSE{,S.chromium.html} \
		|| die "rm licenses failed"

	if ! use suid ; then
		rm usr/lib/kando/chrome-sandbox || die "rm failed"
	fi
}

src_install() {
	doicon usr/share/pixmaps/kando.png

	domenu usr/share/applications/kando.desktop

	insinto /opt/kando
	doins -r usr/lib/kando/.
	fperms +x /opt/kando/chrome_crashpad_handler \
		/opt/kando/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/kando/libvulkan.so.1 /opt/kando/kando
	use suid && fperms u+s,+x /opt/kando/chrome-sandbox

	dosym ../../opt/kando/kando usr/bin/kando

	pax-mark -m "${ED}"/opt/kando/kando
}

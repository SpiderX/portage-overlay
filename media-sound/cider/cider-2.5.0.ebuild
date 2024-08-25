# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi
	fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro
	ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
MULTILIB_COMPAT=( abi_x86_64 )

inherit chromium-2 desktop multilib-build pax-utils unpacker xdg

DESCRIPTION="A new cross-platform Apple Music experience based on Electron"
HOMEPAGE="https://cider.sh"
SRC_URI="cider-linux-debian_x64.deb"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64 suid"
RESTRICT="bindist fetch mirror splitdebug"

RDEPEND="app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/libffi:0[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	dev-libs/libpcre2:0[${MULTILIB_USEDEP}]
	media-libs/alsa-lib[${MULTILIB_USEDEP}]
	media-libs/mesa:0[vulkan,${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	sys-apps/util-linux[${MULTILIB_USEDEP}]
	sys-libs/zlib:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libdrm[${MULTILIB_USEDEP}]
	x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libXau[${MULTILIB_USEDEP}]
	x11-libs/libxcb:=[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite[${MULTILIB_USEDEP}]
	x11-libs/libXdamage[${MULTILIB_USEDEP}]
	x11-libs/libXdmcp[${MULTILIB_USEDEP}]
	x11-libs/libXext[${MULTILIB_USEDEP}]
	x11-libs/libXfixes[${MULTILIB_USEDEP}]
	x11-libs/libxkbcommon[${MULTILIB_USEDEP}]
	x11-libs/libXrandr[${MULTILIB_USEDEP}]
	x11-libs/pango[${MULTILIB_USEDEP}]"

pkg_pretend() {
	use suid || chromium_suid_sandbox_check_kernel_config
}

pkg_nofetch() {
	einfo "Please download cider-linux-debian_x64.deb from"
	einfo "${HOMEPAGE}"
	einfo "and place it into your DISTDIR directory"
}

src_prepare() {
	default
	pushd opt/Cider/locales || die "pushd failed"
	chromium_remove_language_paks
	popd || die "popd failed"

	rm opt/Cider/LICENSE{.electron.txt,S.chromium.html} \
		|| die "rm licenses failed"

	if ! use suid ; then
		rm opt/Cider/chrome-sandbox || die "rm failed"
	fi
}

src_install() {
	for size in 16 32 48 64 128 256 512 1024 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}x${size}"/apps/cider.png
	done
	dosym ../icons/hicolor/1024x1024/apps/cider.png \
		/usr/share/pixmaps/cider.png

	domenu usr/share/applications/cider.desktop

	insinto /opt/Cider
	doins -r opt/Cider/.
	fperms -R +x /opt/Cider/cider /opt/Cider/chrome_crashpad_handler \
		/opt/Cider/lib{EGL,GLESv2,ffmpeg,vk_swiftshader}.so \
		/opt/Cider/libvulkan.so.1
	use suid && fperms u+s,+x /opt/Cider/chrome-sandbox

	dosym ../Cider/cider opt/bin/cider

	pax-mark -m "${ED}"/opt/Cider/cider
}

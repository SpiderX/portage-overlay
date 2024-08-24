# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi
	fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro
	ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
MULTILIB_COMPAT=( abi_x86_64 )

inherit chromium-2 desktop multilib-build pax-utils unpacker xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="HTTP and GraphQL client for developers"
HOMEPAGE="https://insomnia.rest"
SRC_URI="https://github.com/Kong/${MY_PN}/releases/download/core@${PV}/Insomnia.Core-${PV}.deb"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64 suid"
RESTRICT="bindist mirror splitdebug"

RDEPEND="app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	dev-libs/expat[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr[${MULTILIB_USEDEP}]
	dev-libs/nss[${MULTILIB_USEDEP}]
	media-libs/alsa-lib[${MULTILIB_USEDEP}]
	net-print/cups[${MULTILIB_USEDEP}]
	sys-apps/dbus[${MULTILIB_USEDEP}]
	x11-libs/cairo[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libdrm:0[${MULTILIB_USEDEP}]
	x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite[${MULTILIB_USEDEP}]
	x11-libs/libXdamage[${MULTILIB_USEDEP}]
	x11-libs/libXext[${MULTILIB_USEDEP}]
	x11-libs/libXfixes[${MULTILIB_USEDEP}]
	x11-libs/libxkbcommon[${MULTILIB_USEDEP}]
	x11-libs/libXrandr[${MULTILIB_USEDEP}]
	x11-libs/pango[${MULTILIB_USEDEP}]"

pkg_pretend() {
	use suid || chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default
	pushd opt/Insomnia/locales || die "pushd failed"
	chromium_remove_language_paks
	popd || die "popd failed"

	rm opt/Insomnia/LICENSE{.electron.txt,S.chromium.html} \
		|| die "rm licenses failed"

	if ! use suid ; then
		rm opt/Insomnia/chrome-sandbox || die "rm failed"
	fi
}

src_install() {
	for size in 16 32 48 128 256 512 1024 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}x${size}"/apps/insomnia.png
	done
	dosym ../icons/hicolor/1024x1024/apps/insomnia.png \
		/usr/share/pixmaps/insomnia.png

	domenu usr/share/applications/insomnia.desktop

	insinto /opt/Insomnia
	doins -r opt/Insomnia/.
	fperms +x /opt/Insomnia/chrome_crashpad_handler \
		/opt/Insomnia/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/Insomnia/libvulkan.so.1 /opt/Insomnia/insomnia
	use suid && fperms u+s,+x /opt/Insomnia/chrome-sandbox

	dosym ../Insomnia/insomnia opt/bin/insomnia

	pax-mark -m "${ED}"/opt/Insomnia/insomnia
}

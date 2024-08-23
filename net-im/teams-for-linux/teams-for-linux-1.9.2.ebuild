# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi
	fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro
	ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
MULTILIB_COMPAT=( abi_x86_64 )

inherit chromium-2 desktop multilib-build pax-utils unpacker xdg

DESCRIPTION="Unofficial Microsoft Teams for Linux client"
HOMEPAGE="https://github.com/IsmaelMartinez/teams-for-linux"
SRC_URI="https://github.com/IsmaelMartinez/${PN}/releases/download/v${PV}/${PN}_${PV}_amd64.deb"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64 +seccomp suid"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	app-arch/bzip2:0[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/fribidi[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/gmp:0[${MULTILIB_USEDEP}]
	dev-libs/libffi:0[${MULTILIB_USEDEP}]
	dev-libs/libpcre2:0[${MULTILIB_USEDEP}]
	dev-libs/libtasn1:0[${MULTILIB_USEDEP}]
	dev-libs/libunistring:0[${MULTILIB_USEDEP}]
	dev-libs/nettle[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	dev-libs/wayland[${MULTILIB_USEDEP}]
	media-gfx/graphite2[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/libepoxy[${MULTILIB_USEDEP}]
	media-libs/libjpeg-turbo[${MULTILIB_USEDEP}]
	media-libs/libpng:0[${MULTILIB_USEDEP}]
	media-libs/fontconfig:1.0[${MULTILIB_USEDEP}]
	media-libs/freetype:2[${MULTILIB_USEDEP}]
	media-libs/harfbuzz:0[${MULTILIB_USEDEP}]
	media-libs/mesa:0[vulkan,${MULTILIB_USEDEP}]
	net-dns/libidn2:0[${MULTILIB_USEDEP}]
	net-libs/gnutls:0[${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	sys-apps/util-linux[${MULTILIB_USEDEP}]
	sys-libs/zlib:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libdrm:0[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/libXau[${MULTILIB_USEDEP}]
	x11-libs/libXcursor[${MULTILIB_USEDEP}]
	x11-libs/libXdmcp[${MULTILIB_USEDEP}]
	x11-libs/libXi[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite:0[${MULTILIB_USEDEP}]
	x11-libs/libXdamage:0[${MULTILIB_USEDEP}]
	x11-libs/libXext:0[${MULTILIB_USEDEP}]
	x11-libs/libXfixes:0[${MULTILIB_USEDEP}]
	x11-libs/libxkbcommon:0[${MULTILIB_USEDEP}]
	x11-libs/libxkbfile:0[${MULTILIB_USEDEP}]
	x11-libs/libXrandr:0[${MULTILIB_USEDEP}]
	x11-libs/libXrender[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]
	x11-libs/pixman[${MULTILIB_USEDEP}]"

#QA_PREBUILT="opt/slack/chrome-sandbox
#	opt/slack/chrome_crashpad_handler
#	opt/slack/libEGL.so
#	opt/slack/libGLESv2.so
#	opt/slack/libffmpeg.so
#	opt/slack/libvk_swiftshader.so
#	opt/slack/libvulkan.so.1
#	opt/slack/resources/app.asar.unpacked/node_modules/*
#	opt/slack/slack
#	opt/slack/swiftshader/libEGL.so
#	opt/slack/swiftshader/libGLESv2.so"

pkg_pretend() {
	use suid || chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default
	pushd opt/teams-for-linux/locales || die "pushd failed"
	chromium_remove_language_paks
	popd || die "popd failed"

	rm opt/teams-for-linux/LICENSE{S.chromium.html,.electron.txt} \
		|| die "rm failed for licenses"

	if ! use suid ; then
		rm opt/teams-for-linux/chrome-sandbox || die "rm failed"
	fi

	if ! use seccomp ; then
		sed -i '/Exec/s/%U/%U --disable-seccomp-filter-sandbox/' \
			usr/share/applications/teams-for-linux.desktop \
			|| die "sed failed for seccomp"
	fi
}

src_install() {
	for size in 16 24 32 48 64 96 128 256 512 1024 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}x${size}"/apps/teams-for-linux.png
	done
	dosym ../icons/hicolor/1024x1024/apps/teams-for-linux.png \
		/usr/share/pixmaps/teams-for-linux.png

	domenu usr/share/applications/teams-for-linux.desktop

	insinto /opt
	doins -r opt/teams-for-linux
	fperms +x /opt/teams-for-linux/{chrome_crashpad_handler,teams-for-linux}
		/opt/teams-for-linux/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/teams-for-linux/libvulkan.so.1
	use suid && fperms u+s,+x /opt/teams-for-linux/chrome-sandbox

	dosym ../../opt/teams-for-linux/teams-for-linux usr/bin/teams-for-linux

	pax-mark -m "${ED}"/opt/teams-for-linux/teams-for-linux
}

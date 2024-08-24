# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi
	fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro
	ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
MULTILIB_COMPAT=( abi_x86_64 )

inherit chromium-2 desktop multilib-build pax-utils xdg

MY_P="${PN^}-${PV}"

DESCRIPTION="Music focused client for Plex"
HOMEPAGE="https://plexamp.com"
SRC_URI="https://plexamp.plex.tv/plexamp.plex.tv/desktop/${MY_P}.AppImage"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64 +seccomp suid"
RESTRICT="bindist mirror splitdebug"

RDEPEND="app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	dev-libs/dbus-glib:0[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/libdbusmenu:0[gtk,${MULTILIB_USEDEP}]
	dev-libs/libffi:0[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	dev-libs/libpcre2:0[${MULTILIB_USEDEP}]
	media-libs/mesa:0[vulkan,${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	sys-apps/util-linux[${MULTILIB_USEDEP}]
	sys-libs/zlib:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libdrm[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/libXau[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite:0[${MULTILIB_USEDEP}]
	x11-libs/libXcursor:0[${MULTILIB_USEDEP}]
	x11-libs/libXdamage:0[${MULTILIB_USEDEP}]
	x11-libs/libXdmcp[${MULTILIB_USEDEP}]
	x11-libs/libXext:0[${MULTILIB_USEDEP}]
	x11-libs/libXfixes:0[${MULTILIB_USEDEP}]
	x11-libs/libXi:0[${MULTILIB_USEDEP}]
	x11-libs/libxkbcommon[${MULTILIB_USEDEP}]
	x11-libs/libXrandr:0[${MULTILIB_USEDEP}]
	x11-libs/libXtst:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]"

QA_PREBUILT="opt/plexamp/usr/lib/libindicator.so.7
	opt/plexamp/usr/lib/libgconf-2.so.4
	opt/plexamp/usr/lib/libappindicator.so.1
	opt/plexamp/usr/lib/libXss.so.1
	opt/plexamp/usr/lib/libXtst.so.6
	opt/plexamp/usr/lib/libnotify.so.4
	opt/plexamp/resources/treble/libbass.so
	opt/plexamp/resources/treble/libbass_aac.so
	opt/plexamp/resources/treble/libbass_ape.so
	opt/plexamp/resources/treble/libbass_fx.so
	opt/plexamp/resources/treble/libbass_mpc.so
	opt/plexamp/resources/treble/libbassalac.so
	opt/plexamp/resources/treble/libbassdsd.so
	opt/plexamp/resources/treble/libbassflac.so
	opt/plexamp/resources/treble/libbassmix.so
	opt/plexamp/resources/treble/libbassopus.so
	opt/plexamp/resources/treble/libjack.so"

src_unpack() {
	cp "${DISTDIR}"/"${MY_P}".AppImage . || die "cp failed"
	chmod +x "${MY_P}".AppImage || die "chmod failed"
	./"${MY_P}".AppImage --appimage-extract || die "AppImage extract failed"
}

src_prepare() {
	default
	pushd squashfs-root/locales || die "pushd failed"
	chromium_remove_language_paks
	popd || die "popd failed"

	rm -rf squashfs-root/LICENSE{.electron.txt,S.chromium.html} \
		|| die "rm licenses failed"

	sed -i '/Exec/s/AppRun/plexamp/' squashfs-root/plexamp.desktop \
		|| die "sed failed for plexamp.desktop"

	if ! use suid ; then
		rm squashfs-root/chrome-sandbox || die "rm failed"
	fi

	if ! use seccomp ; then
		sed -i '/Exec/s/plexamp/plexamp --disable-seccomp-filter-sandbox/' \
		squashfs-root/plexamp.desktop || die "sed failed with seccomp"
	fi
}

src_install() {
	doicon -s scalable squashfs-root/usr/share/icons/hicolor/scalable/plexamp.svg

	domenu squashfs-root/plexamp.desktop

	insinto /opt/plexamp
	doins -r squashfs-root/.
	fperms -R +x /opt/plexamp/plexamp /opt/plexamp/chrome_crashpad_handler \
		/opt/plexamp/lib{EGL,GLESv2,ffmpeg,vk_swiftshader}.so /opt/plexamp/libvulkan.so.1 \
		/opt/plexamp/resources/app.asar.unpacked/node_modules/electron-media-service/build/Release/electron_media_service.node \
		/opt/plexamp/resources/treble/treble.node \
		/opt/plexamp/resources/treble/libbass{,_aac,_ape,_fx,_mpc,alac,dsd,flac,mix,opus}.so \
		/opt/plexamp/resources/treble/libjack.so
	use suid && fperms u+s,+x /opt/plexamp/chrome-sandbox

	dosym ../../../../../../../../../../../../../../usr/bin/python3 \
		opt/plexamp/resources/app.asar.unpacked/node_modules/electron-media-service/build/node_gyp_bins/python3
	dosym ../plexamp/plexamp opt/bin/plexamp

	pax-mark -m "${ED}"/opt/plexamp/plexamp
}

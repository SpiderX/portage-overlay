# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2317

EAPI=8

PLOCALES="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
PLOCALE_BACKUP="en"

inherit desktop pax-utils plocale xdg

MY_P="${PN^}-${PV}"

DESCRIPTION="Music focused client for Plex"
HOMEPAGE="https://plexamp.com"
SRC_URI="https://plexamp.plex.tv/plexamp.plex.tv/desktop/${MY_P}.AppImage"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="appindicator +seccomp"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-core:2
	dev-libs/dbus-glib:0
	dev-libs/expat:0
	dev-libs/glib:2
	dev-libs/libdbusmenu:0[gtk]
	dev-libs/nspr:0
	dev-libs/nss:0
	media-libs/mesa:0
	net-print/cups:0
	sys-apps/dbus:0
	sys-apps/util-linux:0
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11:0
	x11-libs/libxcb:0/1.12
	x11-libs/libXcomposite:0
	x11-libs/libXcursor:0
	x11-libs/libXdamage:0
	x11-libs/libXext:0
	x11-libs/libXfixes:0
	x11-libs/libXi:0
	x11-libs/libXrandr:0
	x11-libs/libXrender:0
	x11-libs/libXScrnSaver:0
	x11-libs/libXtst:0
	x11-libs/pango:0
	appindicator? ( dev-libs/libayatana-indicator:3 )"

QA_PREBUILT="opt/plexamp/resources/treble/libbass.so
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

	rm -rf squashfs-root/usr/lib || die "rm failed"

	sed -i '/Exec/s/AppRun/plexamp/' squashfs-root/plexamp.desktop \
		|| die "sed failed for plexamp.desktop"

	plocale_find_changes "${S}"/squashfs-root/locales '' '.pak'
	my_rm_loc() {
		rm "${S}"/squashfs-root/locales/"${1}".pak \
			|| die "rm failed for locale ${1}"
	}
	plocale_for_each_disabled_locale my_rm_loc

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
	fperms -R +x /opt/plexamp/plexamp /opt/plexamp/chrome{-sandbox,_crashpad_handler} \
		/opt/plexamp/lib{EGL,GLESv2,ffmpeg,vk_swiftshader}.so /opt/plexamp/libvulkan.so.1 \
		/opt/plexamp/resources/app.asar.unpacked/node_modules/electron-media-service/build/Release/electron_media_service.node \
		/opt/plexamp/resources/treble/treble.node \
		/opt/plexamp/resources/treble/libbass{,_aac,_ape,_fx,_mpc,alac,dsd,flac,mix,opus}.so \
		/opt/plexamp/resources/treble/libjack.so
	dosym ../../../../../../../../../../../../../../usr/bin/python3 \
		opt/plexamp/resources/app.asar.unpacked/node_modules/electron-media-service/build/node_gyp_bins/python3
	dosym ../plexamp/plexamp opt/bin/plexamp

	pax-mark -m "${ED}"/opt/plexamp/plexamp
}

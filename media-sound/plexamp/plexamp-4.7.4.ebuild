# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop pax-utils xdg

MY_P="${PN^}-${PV}"

DESCRIPTION="Music focused client for Plex"
HOMEPAGE="https://plexamp.com"
SRC_URI="https://plexamp.plex.tv/plexamp.plex.tv/desktop/${MY_P}.AppImage"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+abi_x86_64 appindicator +seccomp"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-atk:2
	app-accessibility/at-spi2-core:2
	dev-libs/atk:0
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
	appindicator? ( dev-libs/libappindicator:3 )"

QA_PREBUILT="opt/plexamp/libEGL.so
	opt/plexamp/libGLESv2.so
	opt/plexamp/libffmpeg.so
	opt/plexamp/libvk_swiftshader.so
	opt/plexamp/plexamp
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
	opt/plexamp/resources/treble/libjack.so
	opt/plexamp/usr/lib/libXss.so.1
	opt/plexamp/usr/lib/libXtst.so.6
	opt/plexamp/usr/lib/libappindicator.so.1
	opt/plexamp/usr/lib/libgconf-2.so.4
	opt/plexamp/usr/lib/libindicator.so.7
	opt/plexamp/usr/lib/libnotify.so.4"
QA_FLAGS_IGNORED="opt/plexamp/resources/app.asar.unpacked/node_modules/put/test/c/ftoi
	opt/plexamp/resources/app.asar.unpacked/node_modules/put/test/c/itof
	opt/plexamp/resources/treble/treble.node
	opt/plexamp/resources/treble/obj.target/treble.node
	opt/plexamp/chrome-sandbox"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}"/"${MY_P}".AppImage . || die "cp failed"
	chmod +x "${MY_P}".AppImage || die "chmod failed"
	./"${MY_P}".AppImage --appimage-extract || die "AppImage extract failed"
}

src_prepare() {
	default

	sed -i '/Exec/s/AppRun/plexamp/' squashfs-root/plexamp.desktop \
		|| die "sed failed for plexamp.desktop"

	if ! use seccomp ; then
		sed -i '/Exec/s/plexamp/plexamp --disable-seccomp-filter-sandbox/' \
		squashfs-root/plexamp.desktop || die "sed failed with seccomp"
	fi
}

src_install() {
	for size in 16x16 32x32 48x48 64x64 128x128 256x256 512x512 ; do
		doicon -s "${size}" squashfs-root/usr/share/icons/hicolor/"${size}"/apps/plexamp.png
	done
	dosym ../icons/hicolor/512x512/apps/plexamp.png \
		/usr/share/pixmaps/plexamp.png

	domenu squashfs-root/plexamp.desktop

	insinto /opt/plexamp
	doins -r squashfs-root/.
	fperms -R +x /opt/plexamp/plexamp /opt/plexamp/chrome-sandbox \
		/opt/plexamp/libEGL.so /opt/plexamp/libGLESv2.so /opt/plexamp/libffmpeg.so \
		/opt/plexamp/libvk_swiftshader.so /opt/plexamp/libvulkan.so.1 \
		/opt/plexamp/resources/treble/obj.target/treble.node \
		/opt/plexamp/resources/treble/treble.node \
		/opt/plexamp/resources/treble/libbass{,_aac,_ape,_fx,_mpc,alac,dsd,flac,mix,opus}.so
	dosym ../../../../../../../../../../../../../../usr/bin/python3 \
		opt/plexamp/resources/app.asar.unpacked/node_modules/electron-media-service/build/node_gyp_bins/python3
	dosym ../plexamp/plexamp opt/bin/plexamp

	pax-mark -m "${ED}"/opt/plexamp/plexamp
}

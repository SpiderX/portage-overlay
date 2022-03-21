# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop multilib-build pax-utils xdg

MY_P="${PN^}-${PV}"

DESCRIPTION="SQL client for PostgreSQL and MySQL"
HOMEPAGE="https://arctype.com"
SRC_URI="https://arctype.com/api/download/linux -> ${MY_P}.AppImage"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+abi_x86_64 appindicator"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-atk:2[${MULTILIB_USEDEP}]
	app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	dev-libs/atk:0[${MULTILIB_USEDEP}]
	dev-libs/dbus-glib:0[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/libdbusmenu:0[gtk,${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/mesa:0[${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libdrm:0[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite:0[${MULTILIB_USEDEP}]
	x11-libs/libXcursor:0[${MULTILIB_USEDEP}]
	x11-libs/libXdamage:0[${MULTILIB_USEDEP}]
	x11-libs/libXext:0[${MULTILIB_USEDEP}]
	x11-libs/libXfixes:0[${MULTILIB_USEDEP}]
	x11-libs/libXi:0[${MULTILIB_USEDEP}]
	x11-libs/libXrandr:0[${MULTILIB_USEDEP}]
	x11-libs/libXrender:0[${MULTILIB_USEDEP}]
	x11-libs/libXScrnSaver:0[${MULTILIB_USEDEP}]
	x11-libs/libXtst:0[${MULTILIB_USEDEP}]
	x11-libs/libxshmfence:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]
	appindicator? ( dev-libs/libappindicator:3[${MULTILIB_USEDEP}] )"

QA_PREBUILT="opt/arctype/arctype
	opt/arctype/libEGL.so
	opt/arctype/libGLESv2.so
	opt/arctype/libffmpeg.so
	opt/arctype/libvk_swiftshader.so
	opt/arctype/swiftshader/libEGL.so
	opt/arctype/swiftshader/libGLESv2.so
	opt/arctype/usr/lib/libXss.so.1
	opt/arctype/usr/lib/libXtst.so.6
	opt/arctype/usr/lib/libappindicator.so.1
	opt/arctype/usr/lib/libgconf-2.so.4
	opt/arctype/usr/lib/libindicator.so.7
	opt/arctype/usr/lib/libnotify.so.4"
QA_FLAGS_IGNORED="opt/arctype/chrome-sandbox
	opt/arctype/libvulkan.so.1"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}"/"${MY_P}".AppImage . || die "cp failed"
	chmod +x "${MY_P}".AppImage || die "chmod failed"
	./"${MY_P}".AppImage --appimage-extract || die "AppImage extract failed"
}

src_prepare() {
	default

	sed -i '/Exec/s/AppRun/arctype/' squashfs-root/arctype.desktop \
		|| die "sed failed for arctype.desktop"
}

src_install() {
	for size in 16x16 32x32 48x48 64x64 128x128 256x256 ; do
		doicon -s "${size}" squashfs-root/usr/share/icons/hicolor/"${size}"/apps/arctype.png
	done
	dosym ../icons/hicolor/256x256/apps/arctype.png \
		/usr/share/pixmaps/arctype.png

	domenu squashfs-root/arctype.desktop

	insinto /opt/arctype
	doins -r squashfs-root/.
	fperms -R +x /opt/arctype/arctype /opt/arctype/chrome-sandbox \
		/opt/arctype/libEGL.so /opt/arctype/libGLESv2.so /opt/arctype/libffmpeg.so \
		/opt/arctype/libvk_swiftshader.so /opt/arctype/libvulkan.so.1 \
		/opt/arctype/swiftshader/
	dosym ../arctype/arctype opt/bin/arctype

	pax-mark -m "${ED}"/opt/arctype/arctype
}

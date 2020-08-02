# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop multilib-build pax-utils xdg

DESCRIPTION="Powerful IDE to work with API"
HOMEPAGE="https://testmace.com"
SRC_URI="https://download.testmace.com/TestMace.AppImage"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+abi_x86_64"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-atk:2[${MULTILIB_USEDEP}]
	dev-libs/atk:0[${MULTILIB_USEDEP}]
	dev-libs/dbus-glib:0[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/libdbusmenu:0[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/mesa:0[${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	sys-apps/util-linux:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
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
	x11-libs/pango:0[${MULTILIB_USEDEP}]"

QA_PREBUILT="opt/TestMace/resources/app.asar.unpacked/node_modules/*
	opt/TestMace/usr/lib/*
	opt/TestMace/testmace
	opt/TestMace/libEGL.so
	opt/TestMace/libffmpeg.so
	opt/TestMace/libGLESv2.so"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}"/TestMace.AppImage . || die "cp failed"
	chmod +x TestMace.AppImage || die "chmod failed"
	./TestMace.AppImage --appimage-extract || die "AppImage extract failed"
}

src_prepare() {
	default

	sed -i '/Exec/s/AppRun/testmace/' squashfs-root/testmace.desktop \
		|| die "sed failed for testmace.desktop"
}

src_install() {
	for size in 256x256 512x512 ; do
		doicon -s "${size}" squashfs-root/usr/share/icons/hicolor/"${size}"/apps/testmace.png
	done
	dosym ../icons/hicolor/512x512/apps/testmace.png \
		/usr/share/pixmaps/testmace.png

	domenu squashfs-root/testmace.desktop

	insinto /opt/TestMace
	doins -r squashfs-root/.
	fperms -R +x /opt/TestMace/testmace /opt/TestMace/chrome-sandbox \
		/opt/TestMace/libEGL.so /opt/TestMace/libGLESv2.so /opt/TestMace/libffmpeg.so \
		/opt/TestMace/swiftshader/
	dosym ../TestMace/testmace opt/bin/testmace

	pax-mark -m "${ED}"/opt/TestMace/testmace
}

# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop multilib-build pax-utils unpacker xdg-utils

MY_PN="${PN/-bin/}"
BASE_URI="https://zoom.us/client/latest/zoom_-arch-.deb"

DESCRIPTION="Video conferencing and web conferencing service"
HOMEPAGE="https://zoom.us"
SRC_URI="x86? ( ${BASE_URI/-arch-/i386} -> ${MY_PN}-${PV}_i386.deb )
	amd64? ( ${BASE_URI/-arch-/amd64} -> ${MY_PN}-${PV}_amd64.deb )"

LICENSE="ZOOM"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="pulseaudio"
RESTRICT="bindist mirror"

RDEPEND="dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr[${MULTILIB_USEDEP}]
	dev-libs/nss[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/fontconfig:1.0[${MULTILIB_USEDEP}]
	media-libs/freetype:2[${MULTILIB_USEDEP}]
	media-libs/mesa[${MULTILIB_USEDEP}]
	sys-apps/dbus[${MULTILIB_USEDEP}]
	sys-apps/util-linux[${MULTILIB_USEDEP}]
	sys-libs/zlib:=[${MULTILIB_USEDEP}]
	x11-libs/libdrm[${MULTILIB_USEDEP}]
	x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libxcb[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite[${MULTILIB_USEDEP}]
	x11-libs/libXcursor[${MULTILIB_USEDEP}]
	x11-libs/libXdamage[${MULTILIB_USEDEP}]
	x11-libs/libXext[${MULTILIB_USEDEP}]
	x11-libs/libXfixes[${MULTILIB_USEDEP}]
	x11-libs/libXi[${MULTILIB_USEDEP}]
	x11-libs/libxkbcommon[${MULTILIB_USEDEP}]
	x11-libs/libxshmfence[${MULTILIB_USEDEP}]
	x11-libs/libXrandr[${MULTILIB_USEDEP}]
	x11-libs/libXrender[${MULTILIB_USEDEP}]
	x11-libs/libXtst[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-image[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-keysyms[${MULTILIB_USEDEP}]
	pulseaudio? ( media-sound/pulseaudio[${MULTILIB_USEDEP}] )"
BDEPEND="app-admin/chrpath"

QA_PREBUILT="opt/zoom/QtWebEngineProcess
	opt/zoom/libQt5*
	opt/zoom/qtdiag
	opt/zoom/zoom
	opt/zoom/Qt/labs/*
	opt/zoom/Qt*
	opt/zoom/audio/*
	opt/zoom/egldeviceintegrations/*
	opt/zoom/generic/*
	opt/zoom/iconengines/*
	opt/zoom/imageformats/*
	opt/zoom/platforminputcontexts/*
	opt/zoom/platforms/*
	opt/zoom/platformthemes/*
	opt/zoom/xcbglintegrations/*"

S="${WORKDIR}"

src_prepare() {
	default

	# Fix icon, categories and libraries path
	sed -i  -e '/Icon/s/Zoom.png/Zoom/' \
		-e '/Categories/s/Application;//' \
		-e '/Exec/s|=|=/usr/bin/env LD_LIBRARY_PATH="\\$LD_LIBRARY_PATH:/opt/zoom" |' \
		usr/share/applications/Zoom.desktop || die "sed failed for Zoom.desktop"
	chrpath -r '' opt/zoom/platforminputcontexts/libfcitxplatforminputcontextplugin.so \
		|| die "chrpath failed"
	scanelf -Xr opt/zoom/platforminputcontexts/libfcitxplatforminputcontextplugin.so \
		|| die "scanelf failed"
}

src_install() {
	doicon usr/share/pixmaps/Zoom.png usr/share/pixmaps/application-x-zoom.png
	domenu usr/share/applications/Zoom.desktop
	insinto /usr/share/mime/packages
	doins usr/share/mime/packages/zoom.xml

	insinto /opt/zoom
	doins -r opt/zoom/.
	fperms +x /opt/zoom/zoom
	dosym ../../opt/zoom/zoom usr/bin/zoom

	pax-mark -m "${ED}"/opt/zoom/zoom
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

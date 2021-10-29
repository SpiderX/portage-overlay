# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop multilib-build pax-utils unpacker xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Video conferencing and web conferencing service"
HOMEPAGE="https://zoom.us"
SRC_URI="https://cdn.zoom.us/prod/${PV}/zoom_amd64.deb -> zoom-${PV}_amd64.deb"

LICENSE="ZOOM"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="pulseaudio"
RESTRICT="bindist mirror"

# no bundled libs for EGLFS
RDEPEND="!games-engines/zoom
	!net-im/zoom
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/libpcre:3[${MULTILIB_USEDEP}]
	dev-libs/nspr[${MULTILIB_USEDEP}]
	dev-libs/nss[${MULTILIB_USEDEP}]
	dev-qt/qt3d[qml]
	dev-qt/qtgui:5[eglfs]
	media-libs/fontconfig:1.0[${MULTILIB_USEDEP}]
	media-libs/freetype:2[${MULTILIB_USEDEP}]
	media-libs/mesa[${MULTILIB_USEDEP}]
	sys-apps/dbus[${MULTILIB_USEDEP}]
	sys-apps/util-linux[${MULTILIB_USEDEP}]
	sys-libs/zlib:=[${MULTILIB_USEDEP}]
	x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libxcb[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite[${MULTILIB_USEDEP}]
	x11-libs/libXcursor[${MULTILIB_USEDEP}]
	x11-libs/libXdamage[${MULTILIB_USEDEP}]
	x11-libs/libXext[${MULTILIB_USEDEP}]
	x11-libs/libXfixes[${MULTILIB_USEDEP}]
	x11-libs/libXi[${MULTILIB_USEDEP}]
	x11-libs/libXrandr[${MULTILIB_USEDEP}]
	x11-libs/libXrender[${MULTILIB_USEDEP}]
	x11-libs/libXtst[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-image[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-keysyms[${MULTILIB_USEDEP}]
	pulseaudio? ( media-sound/pulseaudio[${MULTILIB_USEDEP}] )
	!pulseaudio? ( media-libs/alsa-lib:0[${MULTILIB_USEDEP}] )"
BDEPEND="sys-apps/fix-gnustack
	!pulseaudio? ( dev-util/bbe )"

QA_PREBUILT="opt/zoom/aomhost
	opt/zoom/audio/libqt*.so
	opt/zoom/egldeviceintegrations/libqeglfs-*-integration.so
	opt/zoom/generic/libq*.plugin.so
	opt/zoom/iconengines/libqsvgicon.so
	opt/zoom/imageformats/libq*.so
	opt/zoom/libaomagent.so
	opt/zoom/libQt5*
	opt/zoom/libOpenCL.so.1
	opt/zoom/platforminputcontexts/lib*platforminputcontextplugin.so
	opt/zoom/platforms/libq*.so
	opt/zoom/platformthemes/libqgtk3.so
	opt/zoom/Qt*
	opt/zoom/qtdiag
	opt/zoom/xcbglintegrations/libqxcb-*.so
	opt/zoom/zoom
	opt/zoom/ZoomLauncher
	opt/zoom/zopen"

S="${WORKDIR}"

src_prepare() {
	default

	# Fix icon, categories and libraries path
	sed -i  -e '/Icon/s/Zoom.png/Zoom/' \
		-e '/Categories/s/Application;//' \
		-e '/Exec/s|=|=/usr/bin/env LD_LIBRARY_PATH="\\$LD_LIBRARY_PATH:/opt/zoom" |' \
		usr/share/applications/Zoom.desktop || die "sed failed for Zoom.desktop"
	scanelf -Xr opt/zoom/platforminputcontexts/libfcitxplatforminputcontextplugin.so \
			opt/zoom/libturbojpeg.so || die "scanelf failed"

	# Zoom cannot use any ALSA sound devices if it finds libpulse.
	# This causes breakage if media-sound/apulse[sdk] is installed.
	if ! use pulseaudio; then
		bbe -e 's/libpulse.so/IgNoRePuLsE/' zoom >zoom.tmp || die "bbe failed"
		mv zoom.tmp zoom || die "mv failed"
	fi
}

src_install() {
	fix-gnustack -f opt/zoom/aomhost > /dev/null \
		|| die "removing execstack flag failed"

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

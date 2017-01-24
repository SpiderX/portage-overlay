# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

MY_PN="${PN/-bin/}"

inherit eutils gnome2-utils unpacker

DESCRIPTION="Free text and calls"
HOMEPAGE="http://www.viber.com/"
SRC_URI="http://download.cdn.viber.com/cdn/desktop/Linux/${MY_PN}.deb"

LICENSE="no-source-code"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="strip"

RDEPEND="dev-libs/glib:2
	dev-libs/libxml2:2
	dev-libs/libxslt:0
	dev-libs/nspr:0
	dev-libs/nss:0
	media-libs/alsa-lib:0
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/gst-plugins-base:1.0
	media-libs/gstreamer:1.0
	media-libs/libpng:1.2
	media-sound/pulseaudio:0
	net-print/cups:0
	sys-apps/dbus:0
	sys-libs/zlib:0
	x11-libs/libICE:0
	x11-libs/libSM:0
	x11-libs/libX11:0
	x11-libs/libxcb:0/1.12
	x11-libs/libXcomposite:0
	x11-libs/libXcursor:0
	x11-libs/libXdamage:0
	x11-libs/libXext:0
	x11-libs/libXfixes:0
	x11-libs/libXi:0
	x11-libs/libXrender:0
	x11-libs/libXScrnSaver:0
	x11-libs/libXtst:0
	x11-libs/xcb-util-image:0
	x11-libs/xcb-util-keysyms:0
	x11-libs/xcb-util-renderutil:0
	x11-libs/xcb-util-wm:0"

QA_PREBUILT="/opt/viber/QtWebEngineProcess
	/opt/viber/plugins/*/*.so
	/opt/viber/lib/*
	/opt/viber/qml/*"

S="${WORKDIR}"

src_install() {
	newicon -s scalable usr/share/icons/hicolor/scalable/apps/${MY_PN^}.svg \
		${MY_PN}.svg
	for size in 16x16 24x24 32x32 48x48 64x64 96x96 128x128 256x256; do
		newicon -s ${size%%x*} usr/share/${MY_PN}/${size}.png ${MY_PN}.png
	done
	dosym /usr/share/icons/hicolor/96x96/apps/${MY_PN}.png \
		/usr/share/pixmaps/${MY_PN}.png

	domenu usr/share/applications/${MY_PN}.desktop

	insinto /opt/${MY_PN}
	doins -r opt/${MY_PN}/.

	fperms +x /opt/${MY_PN}/${MY_PN^}
	dosym /opt/${MY_PN}/${MY_PN^} /usr/bin/${MY_PN}
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

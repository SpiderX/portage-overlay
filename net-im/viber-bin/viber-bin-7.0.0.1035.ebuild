# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/-bin/}"
MULTILIB_COMPAT=( abi_x86_64 )

inherit eutils gnome2-utils multilib-build pax-utils unpacker xdg-utils

DESCRIPTION="Free text and calls"
HOMEPAGE="http://www.viber.com/"
SRC_URI="http://download.cdn.viber.com/cdn/desktop/Linux/${MY_PN}.deb"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 -*"
IUSE="pax_kernel"
RESTRICT="bindist mirror strip"

DEPEND="sys-apps/fix-gnustack"
RDEPEND="dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	dev-libs/wayland:0[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/fontconfig:1.0[${MULTILIB_USEDEP}]
	media-libs/freetype:2[${MULTILIB_USEDEP}]
	media-libs/gst-plugins-base:1.0[${MULTILIB_USEDEP}]
	media-libs/gstreamer:1.0[${MULTILIB_USEDEP}]
	media-sound/pulseaudio:0[${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	sys-libs/zlib:0/1[${MULTILIB_USEDEP}]
	x11-libs/libdrm:0[${MULTILIB_USEDEP}]
	x11-libs/libICE:0[${MULTILIB_USEDEP}]
	x11-libs/libSM:0[${MULTILIB_USEDEP}]
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
	x11-libs/xcb-util-image:0[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-keysyms:0[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-renderutil:0[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-wm:0[${MULTILIB_USEDEP}]"

QA_PREBUILT="/opt/viber/QtWebEngineProcess
	/opt/viber/plugins/*/*.so
	/opt/viber/lib/*
	/opt/viber/qml/*"

S="${WORKDIR}"

src_install() {
	# Remove execstack flags
	fix-gnustack -f opt/${MY_PN}/lib/libQt5WebEngineCore.so.5 > /dev/null \
		|| die "removing execstack flag failed"

	if use pax_kernel; then
		pax-mark -m opt/${MY_PN}/${MY_PN^} \
			opt/${MY_PN}/QtWebEngineProcess
	fi

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

	fperms +x /opt/${MY_PN}/${MY_PN^} \
		/opt/${MY_PN}/QtWebEngineProcess \
		/opt/${MY_PN}/plugins/*/lib*.so \
		/opt/${MY_PN}/qml/Qt*/lib*.so \
		/opt/${MY_PN}/qml/Qt/labs/*/lib*.so \
		/opt/${MY_PN}/qml/QtGraphicalEffects/*/lib*.so \
		/opt/${MY_PN}/qml/QtQml/*/lib*.so \
		/opt/${MY_PN}/qml/QtQuick/*/lib*.so \
		/opt/${MY_PN}/qml/QtQuick/Controls/Styles/Flat/lib*.so \
		/opt/${MY_PN}/qml/QtQuick/Controls.2/*/lib*.so \
		/opt/${MY_PN}/qml/QtQuick/Dialogs/Private/lib*.so \
		/opt/${MY_PN}/qml/QtQuick/VirtualKeyboard/Styles/lib*.so
	dosym /opt/${MY_PN}/${MY_PN^} /usr/bin/${MY_PN}
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}

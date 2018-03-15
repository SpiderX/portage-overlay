# Copyright 1999-2018 Gentoo Foundation
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
IUSE="apulse pax_kernel +pulseaudio"
REQUIRED_USE="^^ ( apulse pulseaudio )"

RESTRICT="bindist mirror strip"

DEPEND="sys-apps/fix-gnustack"
RDEPEND="dev-libs/expat[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr[${MULTILIB_USEDEP}]
	dev-libs/nss[${MULTILIB_USEDEP}]
	dev-libs/wayland[${MULTILIB_USEDEP}]
	media-libs/alsa-lib[${MULTILIB_USEDEP}]
	media-libs/fontconfig:1.0[${MULTILIB_USEDEP}]
	media-libs/freetype:2[${MULTILIB_USEDEP}]
	media-libs/gst-plugins-base:1.0[${MULTILIB_USEDEP}]
	media-libs/gstreamer:1.0[${MULTILIB_USEDEP}]
	net-print/cups[${MULTILIB_USEDEP}]
	sys-apps/dbus[${MULTILIB_USEDEP}]
	sys-libs/zlib:0/1[${MULTILIB_USEDEP}]
	x11-libs/libdrm[${MULTILIB_USEDEP}]
	x11-libs/libICE[${MULTILIB_USEDEP}]
	x11-libs/libSM[${MULTILIB_USEDEP}]
	x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite[${MULTILIB_USEDEP}]
	x11-libs/libXcursor[${MULTILIB_USEDEP}]
	x11-libs/libXdamage[${MULTILIB_USEDEP}]
	x11-libs/libXext[${MULTILIB_USEDEP}]
	x11-libs/libXfixes[${MULTILIB_USEDEP}]
	x11-libs/libXi[${MULTILIB_USEDEP}]
	x11-libs/libXrandr[${MULTILIB_USEDEP}]
	x11-libs/libXrender[${MULTILIB_USEDEP}]
	x11-libs/libXScrnSaver[${MULTILIB_USEDEP}]
	x11-libs/libXtst[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-image[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-keysyms[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-renderutil[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-wm[${MULTILIB_USEDEP}]
	apulse? ( media-sound/apulse[${MULTILIB_USEDEP}] )
	pulseaudio? ( media-sound/pulseaudio[${MULTILIB_USEDEP}] )"

QA_PREBUILT="/opt/viber/QtWebEngineProcess
	/opt/viber/plugins/*/*.so
	/opt/viber/lib/*
	/opt/viber/qml/*"

S="${WORKDIR}"

src_prepare() {
	default

	if use apulse ; then
		sed -i '/Exec=/s|/opt|apulse /opt|' \
			usr/share/applications/"${MY_PN}".desktop || die "sed failed"
	fi
}
src_install() {
	# Remove execstack flags
	fix-gnustack -f opt/"${MY_PN}"/lib/libQt5WebEngineCore.so.5 > /dev/null \
		|| die "removing execstack flag failed"

	newicon -s scalable usr/share/icons/hicolor/scalable/apps/"${MY_PN^}".svg \
		"${MY_PN}".svg
	for size in 16x16 24x24 32x32 48x48 64x64 96x96 128x128 256x256; do
		newicon -s "${size%%x*}" usr/share/"${MY_PN}"/"${size}".png "${MY_PN}".png
	done
	dosym ../icons/hicolor/96x96/apps/"${MY_PN}".png \
		/usr/share/pixmaps/"${MY_PN}".png

	domenu usr/share/applications/"${MY_PN}".desktop

	insinto /opt/"${MY_PN}"
	doins -r opt/"${MY_PN}"/.

	if use pax_kernel; then
		pax-mark -m "${ED%/}"/opt/"${MY_PN}"/"${MY_PN^}" \
			"${ED%/}"/opt/"${MY_PN}"/QtWebEngineProcess
	fi

	fperms +x /opt/"${MY_PN}"/"${MY_PN^}" \
		/opt/"${MY_PN}"/QtWebEngineProcess

	dosym ../../opt/"${MY_PN}"/"${MY_PN^}" /usr/bin/"${MY_PN}"
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

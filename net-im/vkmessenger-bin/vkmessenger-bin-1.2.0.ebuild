# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/-bin/}"
BASE_URI="https://desktop.userapi.com/linux_arch_/master/vk.zip"

inherit eutils gnome2-utils

DESCRIPTION="Simple and Easy App for Messaging on VK"
HOMEPAGE="https://vk.com/desktop_app"
SRC_URI="
	x86? ( ${BASE_URI/_arch_/32} -> ${MY_PN}-${PV}-x32.zip )
	amd64? ( ${BASE_URI/_arch_/64} -> ${MY_PN}-${PV}-x64.zip )"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"

RDEPEND="dev-libs/atk:0
	dev-libs/expat:0
	dev-libs/glib:2
	dev-libs/nspr:0
	dev-libs/nss:0
	gnome-base/gconf:2
	media-libs/alsa-lib:0
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	net-print/cups:0
	sys-apps/dbus:0
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/libX11:0
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
	x11-libs/pango:0"

QA_PREBUILT="opt/vkmessenger/vk"

S="${WORKDIR}"

src_install() {
	newicon -s 256 icon256.png vk.png
	dosym /opt/vkmessenger/icon256.png /usr/share/pixmaps/vk.png

	domenu "${FILESDIR}"/vk.desktop

	insinto /opt/vkmessenger
	doins -r .

	fperms +x /opt/vkmessenger/vk
	dosym /opt/vkmessenger/vk /usr/bin/vk
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

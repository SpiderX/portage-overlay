# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-bin/}"

inherit desktop multilib-build pax-utils xdg-utils

QA_PREBUILT="opt/vk-messenger/vk
	opt/vk-messenger/libffmpeg.so
	opt/vk-messenger/libnode.so
	opt/vk-messenger/resources/app/dist/libEGL.so
	opt/vk-messenger/resources/app/dist/libGLESv2.so"
BASE_URI="https://desktop.userapi.com/linux_arch_/master/vk.zip"

DESCRIPTION="Simple and Easy App for Messaging on VK"
HOMEPAGE="https://vk.com/messenger"
SRC_URI="
	amd64? ( ${BASE_URI/_arch_/64} -> ${MY_PN}-${PV}-x64.zip )
	x86? ( ${BASE_URI/_arch_/32} -> ${MY_PN}-${PV}-x32.zip )"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/atk:0[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	gnome-base/gconf:2[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/fontconfig:1.0[${MULTILIB_USEDEP}]
	media-libs/freetype:2[${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:2[${MULTILIB_USEDEP}]
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
DEPEND="sys-apps/fix-gnustack"
BDEPEND="app-arch/unzip"

S="${WORKDIR}"

src_install() {
	fix-gnustack -f resources/app/dist/libppapi_voip_swiftshader_x86_64.so \
		> /dev/null || die "execstack failed for libppapi_voip_swiftshader_x86_64.so"
	fix-gnustack -f resources/app/dist/libppapi_voip_x86_64.so \
		> /dev/null || die "execstack failed for libppapi_voip_x86_64.so"

	newicon -s 256 icon256.png vk-messenger.png
	dosym ../../../opt/vk-messenger/icon256.png \
		/usr/share/pixmaps/vk-messenger.png
	domenu "${FILESDIR}"/vk-messenger.desktop

	insinto /opt/vk-messenger
	doins -r .
	fperms +x /opt/vk-messenger/vk
	dosym ../../opt/vk-messenger/vk /usr/bin/vk-messenger

	pax-mark -m "${ED}"/opt/vk-messenger/vk
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

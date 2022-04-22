# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop multilib-build pax-utils systemd unpacker xdg

DESCRIPTION="Fortinet VPN client"
HOMEPAGE="https://www.fortinet.com/products/endpoint-security/forticlient"
SRC_URI="https://filestore.fortinet.com/${PN}/downloads/FortiClientFullVPNInstaller_${PV}.deb"

LICENSE="Fortinet"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="bindist mirror"

# dev-libs/libappindicator:2 required by fortitray
RDEPEND="app-accessibility/at-spi2-atk:2[${MULTILIB_USEDEP}]
	app-crypt/libsecret:0[${MULTILIB_USEDEP}]
	dev-libs/atk:0[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/libglvnd:0[${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	sys-apps/util-linux:0[${MULTILIB_USEDEP}]
	sys-libs/zlib:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libnotify:0[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0[${MULTILIB_USEDEP}]
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

QA_PREBUILT="opt/forticlient/gui/FortiClient-linux-x64/FortiClient
	opt/forticlient/gui/FortiClient-linux-x64/libEGL.so
	opt/forticlient/gui/FortiClient-linux-x64/libffmpeg.so
	opt/forticlient/gui/FortiClient-linux-x64/libGLESv2.so
	opt/forticlient/confighandler
	opt/forticlient/fortitray
	opt/forticlient/fortivpn
	opt/forticlient/fortitraylauncher
	opt/forticlient/fctsched
	opt/forticlient/vpn"
QA_FLAGS_IGNORED="opt/forticlient/gui/FortiClient-linux-x64/swiftshader/libEGL.so
	opt/forticlient/gui/FortiClient-linux-x64/swiftshader/libGLESv2.so
	opt/forticlient/gui/FortiClient-linux-x64/libVkICD_mock_icd.so"

S="${WORKDIR}"

src_install() {
	for size in 16x16 22x22 24x24 32x32 48x48 64x64 128x128 256x256 ; do
		newicon -s "${size%%x*}" usr/share/icons/hicolor/"${size}"/apps/forticlient.png \
			forticlient.png
	done
	dosym ../icons/hicolor/256x256/apps/forticlient.png \
		/usr/share/pixmaps/forticlient.png

	insinto /usr/share/polkit-1/actions
	doins usr/share/polkit-1/actions/org.fortinet.forti{client,tray}.policy

	domenu usr/share/applications/forticlient.desktop

	insinto /etc/forticlient
	doins etc/forticlient/config.db

	exeinto /opt/forticlient
	doexe opt/forticlient/confighandler \
		opt/forticlient/fctsched \
		opt/forticlient/fortitray \
		opt/forticlient/fortitraylauncher \
		opt/forticlient/fortivpn \
		opt/forticlient/vpn

	insinto /opt/forticlient/images
	doins -r opt/forticlient/images/.

	insinto /opt/forticlient/gui/FortiClient-linux-x64
	doins -r opt/forticlient/gui/FortiClient-linux-x64/.

	fperms +x /opt/forticlient/gui/FortiClient-linux-x64/swiftshader/libEGL.so \
		/opt/forticlient/gui/FortiClient-linux-x64/swiftshader/libGLESv2.so \
		/opt/forticlient/gui/FortiClient-linux-x64/FortiClient \
		/opt/forticlient/gui/FortiClient-linux-x64/libEGL.so \
		/opt/forticlient/gui/FortiClient-linux-x64/libGLESv2.so \
		/opt/forticlient/gui/FortiClient-linux-x64/libVkICD_mock_icd.so \
		/opt/forticlient/gui/FortiClient-linux-x64/libffmpeg.so

	dodir /opt/bin
	dosym ../forticlient/gui/FortiClient-linux-x64/FortiClient opt/bin/FortiClient
	dosym ../forticlient/fortivpn opt/bin/fortivpn

	systemd_dounit lib/systemd/system/forticlient-scheduler.service

	pax-mark -m "${ED}"/opt/forticlient/gui/FortiClient-linux-x64/FortiClient
}

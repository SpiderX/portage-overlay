# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-bin/}"
MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop multilib-build pax-utils unpacker xdg

DESCRIPTION="Database manager for MySQL, PostgreSQL, SQL Server and MongoDB"
HOMEPAGE="https://github.com/dbgate/dbgate"
SRC_URI="https://github.com/dbgate/${MY_PN}/releases/download/v${PV}/${MY_PN}-linux-${PV}.deb"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
IUSE="+abi_x86_64 appindicator suid"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-atk:2[${MULTILIB_USEDEP}]
	app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	dev-libs/atk:0[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
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
	x11-libs/pango:0[${MULTILIB_USEDEP}]
	appindicator? ( dev-libs/libappindicator:3[${MULTILIB_USEDEP}] )"

QA_PREBUILT="opt/dbgate/dbgate
	opt/dbgate/libffmpeg.so
	opt/dbgate/libEGL.so
	opt/dbgate/libGLESv2.so
	opt/dbgate/libvk_swiftshader.so
	opt/dbgate/swiftshader/libEGL.so
	opt/dbgate/swiftshader/libGLESv2.so"

S="${WORKDIR}"

src_install() {
	doicon -s 256 usr/share/icons/hicolor/0x0/apps/dbgate.png
	dosym ../icons/hicolor/256x256/apps/dbgate.png \
		/usr/share/pixmaps/dbgate.png

	domenu usr/share/applications/dbgate.desktop

	insinto /opt/dbgate
	doins -r opt/dbgate/.
	fperms -R +x /opt/dbgate/dbgate /opt/dbgate/chrome-sandbox \
		/opt/dbgate/swiftshader/ \
		/opt/dbgate/lib{EGL,ffmpeg,GLESv2,vk_swiftshader,vulkan}.so

	use suid && fperms u+s /opt/dbgate/chrome-sandbox
	dosym ../../opt/dbgate/dbgate /usr/bin/dbgate

	pax-mark -m "${ED}"/opt/dbgate/dbgate
}

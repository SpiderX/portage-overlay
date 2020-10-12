# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop multilib-build pax-utils unpacker xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="SQL client for MySQL, Postgres, SQLite, SQL Server, and more"
HOMEPAGE="https://www.beekeeperstudio.io"
SRC_URI="https://dl.bintray.com/beekeeper-studio/releases/${MY_PN}_${PV}_amd64.deb"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+abi_x86_64 appindicator"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-atk:2[${MULTILIB_USEDEP}]
	app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	dev-libs/atk:0[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
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

S="${WORKDIR}"

QA_PREBUILT="opt/beekeeper-studio/crashpad_handler
	opt/beekeeper-studio/swiftshader/libEGL.so
	opt/beekeeper-studio/swiftshader/libGLESv2.so
	opt/beekeeper-studio/libEGL.so
	opt/beekeeper-studio/beekeeper-studio-bin
	opt/beekeeper-studio/libffmpeg.so
	opt/beekeeper-studio/libvk_swiftshader.so
	opt/beekeeper-studio/libGLESv2.so"

src_prepare() {
	default

	sed -i '/Exec/s/"\/opt\/Beekeeper Studio\/beekeeper-studio"/beekeeper-studio/' \
		usr/share/applications/beekeeper-studio.desktop \
		|| die "sed failed for arctype.desktop"
}

src_install() {
	for size in 16x16 24x24 32x32 48x48 64x64 96x96 128x128 256x256 512x512 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}"/apps/beekeeper-studio.png
	done
	dosym ../icons/hicolor/512x512/apps/beekeeper-studio.png \
		/usr/share/pixmaps/beekeeper-studio.png

	domenu usr/share/applications/beekeeper-studio.desktop

	insinto /opt/beekeeper-studio
	doins -r opt/"Beekeeper Studio"/.
	fperms -R +x /opt/beekeeper-studio/beekeeper-studio /opt/beekeeper-studio/beekeeper-studio-bin \
		/opt/beekeeper-studio/chrome-sandbox /opt/beekeeper-studio/crashpad_handler \
		/opt/beekeeper-studio/libEGL.so /opt/beekeeper-studio/libGLESv2.so \
		/opt/beekeeper-studio/libffmpeg.so /opt/beekeeper-studio/libvk_swiftshader.so \
		/opt/beekeeper-studio/swiftshader/
	dosym ../beekeeper-studio/beekeeper-studio-bin opt/bin/beekeeper-studio

	pax-mark -m "${ED}"/opt/beekeeper-studio/beekeeper-studio-bin
}

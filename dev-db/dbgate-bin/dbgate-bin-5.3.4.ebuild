# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2317

EAPI=8

PLOCALES="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
PLOCALE_BACKUP="en"

inherit desktop pax-utils plocale unpacker xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Database manager for MySQL, PostgreSQL, SQL Server and MongoDB"
HOMEPAGE="https://github.com/dbgate/dbgate"
SRC_URI="https://github.com/dbgate/${MY_PN}/releases/download/v${PV}/${MY_PN}-${PV}-linux_amd64.deb"
S="${WORKDIR}"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
IUSE="appindicator suid"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-apps/util-linux
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libxcb:0/1.12
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/pango:0
	appindicator? ( dev-libs/libayatana-indicator:3 )"

src_prepare() {
	default

	plocale_find_changes "${S}"/opt/DbGate/locales '' '.pak'
	my_rm_loc() {
		rm "${S}"/opt/DbGate/locales/"${1}".pak \
			|| die "rm failed for locale ${1}"
	}
	plocale_for_each_disabled_locale my_rm_loc
}

src_install() {
	for size in 16 32 48 64 128 256 512 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}x${size}"/apps/dbgate.png
	done
	dosym ../icons/hicolor/512x512/apps/dbgate.png \
		/usr/share/pixmaps/dbgate.png

	domenu usr/share/applications/dbgate.desktop

	insinto /opt/DbGate
	doins -r opt/DbGate/.
	fperms -R +x /opt/DbGate/dbgate /opt/DbGate/chrome{-sandbox,_crashpad_handler} \
		/opt/DbGate/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/DbGate/libvulkan.so.1 \
		/opt/DbGate/resources/app.asar.unpacked/node_modules/better-sqlite3/build/Release/better_sqlite3.node

	use suid && fperms u+s /opt/DbGate/chrome-sandbox
	dosym ../../opt/DbGate/dbgate /usr/bin/dbgate

	pax-mark -m "${ED}"/opt/DbGate/dbgate
}

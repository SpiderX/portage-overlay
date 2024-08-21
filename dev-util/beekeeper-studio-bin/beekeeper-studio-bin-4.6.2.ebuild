# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2317

EAPI=8

PLOCALES="am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk vi zh-CN zh-TW"
PLOCALE_BACKUP="en"

inherit desktop pax-utils plocale unpacker xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="SQL client for MySQL, Postgres, SQLite, SQL Server, and more"
HOMEPAGE="https://www.beekeeperstudio.io"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/releases/download/v${PV}/${MY_PN}_${PV}_amd64.deb"
S="${WORKDIR}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="appindicator"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	net-print/cups
	sys-apps/dbus
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
	x11-libs/pango
	appindicator? ( dev-libs/libayatana-indicator:3 )"

src_prepare() {
	default

	sed -i  -e '/Exec/s|Beekeeper Studio|beekeeper-studio|' \
		-e '/MimeType/s|application/vnd.sqlite3;||2g' \
		usr/share/applications/beekeeper-studio.desktop \
		|| die "sed failed for arctype.desktop"

	plocale_find_changes "${S}/opt/Beekeeper Studio/locales" '' '.pak'
	my_rm_loc() {
		rm "${S}/opt/Beekeeper Studio/locales/${1}".pak \
			|| die "rm failed for locale ${1}"
	}
	plocale_for_each_disabled_locale my_rm_loc
}

src_install() {
	for size in 16 24 32 48 64 96 128 256 512 1024 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}x${size}"/apps/beekeeper-studio.png
	done
	dosym ../icons/hicolor/1024x1024/apps/beekeeper-studio.png \
		/usr/share/pixmaps/beekeeper-studio.png

	domenu usr/share/applications/beekeeper-studio.desktop
	insinto /usr/share/mime/packages
	doins usr/share/mime/packages/beekeeper-studio.xml

	insinto /opt/beekeeper-studio
	doins -r opt/"Beekeeper Studio"/.
	fperms -R +x /opt/beekeeper-studio/beekeeper-studio{,-bin} \
		/opt/beekeeper-studio/chrome{-sandbox,_crashpad_handler} \
		/opt/beekeeper-studio/lib{EGL,GLESv2,ffmpeg,vk_swiftshader}.so \
		/opt/beekeeper-studio/libvulkan.so.1 /opt/beekeeper-studio/swiftshader
	dosym ../beekeeper-studio/beekeeper-studio-bin opt/bin/beekeeper-studio

	pax-mark -m "${ED}"/opt/beekeeper-studio/beekeeper-studio-bin
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2317

EAPI=8

PLOCALES="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
PLOCALE_BACKUP="en"

inherit desktop pax-utils plocale unpacker xdg

DESCRIPTION="A minimal markdown editor and reader"
HOMEPAGE="https://typora.io"
SRC_URI="https://typora.io/linux/${PN}_${PV}_amd64.deb"
S="${WORKDIR}"

LICENSE="Typora"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="appindicator"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-core:2
	app-crypt/libsecret:0
	dev-libs/expat:0
	dev-libs/glib:2
	dev-libs/nspr:0
	dev-libs/nss:0
	media-libs/alsa-lib:0
	media-libs/fontconfig:1.0
	media-libs/mesa:0
	net-print/cups:0
	sys-apps/dbus:0
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libdrm:0
	x11-libs/libX11:0
	x11-libs/libxcb:0/1.12
	x11-libs/libXcomposite:0
	x11-libs/libXdamage:0
	x11-libs/libXext:0
	x11-libs/libXfixes:0
	x11-libs/libxkbcommon:0
	x11-libs/libXrandr:0
	x11-libs/libxshmfence:0
	x11-libs/pango:0
	appindicator? ( dev-libs/libayatana-indicator:3 )"

src_prepare() {
	default

	plocale_find_changes "${S}"/usr/share/typora/locales '' '.pak'
	my_rm_loc() {
		rm "${S}"/usr/share/typora/locales/"${1}".pak \
			|| die "rm failed for locale ${1}"
	}
	plocale_for_each_disabled_locale my_rm_loc
}

src_install() {
	for size in 32 64 128 256 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}x${size}"/apps/typora.png
	done
	dosym ../icons/hicolor/256x256/apps/typora.png \
		/usr/share/pixmaps/typora.png

	domenu usr/share/applications/typora.desktop

	insinto /opt/Typora
	doins -r usr/share/typora/.
	fperms +x /opt/Typora/chrome{-sandbox,_crashpad_handler} \
		/opt/Typora/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/Typora/libvulkan.so.1 /opt/Typora/Typora \
		/opt/Typora/resources/node_modules/fswin/build/Release/fswin.node \
		/opt/Typora/resources/node_modules/spellchecker/node_modules/cld/build/Release/cld.node \
		/opt/Typora/resources/node_modules/vscode-ripgrep/bin/rg

	dosym ../Typora/Typora opt/bin/typora

	pax-mark -m "${ED}"/opt/Typora/Typora
}

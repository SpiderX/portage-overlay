# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2317

EAPI=8

PLOCALES="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
PLOCALE_BACKUP="en"

inherit desktop pax-utils plocale unpacker xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="HTTP and GraphQL client for developers"
HOMEPAGE="https://insomnia.rest"
SRC_URI="https://github.com/Kong/${MY_PN}/releases/download/core@${PV}/Insomnia.Core-${PV}.deb"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
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
	x11-libs/libdrm:0
	x11-libs/libX11
	x11-libs/libxcb:0/1.12
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/pango
	appindicator? ( dev-libs/libayatana-indicator:3 )"

src_prepare() {
	default

	if use appindicator ; then
		sed -i '/Exec/s|=|=env XDG_CURRENT_DESKTOP=Unity |' \
			usr/share/applications/insomnia.desktop \
			|| die "sed failed for insomnia.desktop"
	fi
	plocale_find_changes "${S}"/opt/Insomnia/locales '' '.pak'
	my_rm_loc() {
		rm "${S}"/opt/Insomnia/locales/"${1}".pak \
			|| die "rm failed for locale ${1}"
	}
	plocale_for_each_disabled_locale my_rm_loc
}

src_install() {
	for size in 16 32 48 128 256 512 1024 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}x${size}"/apps/insomnia.png
	done
	dosym ../icons/hicolor/1024x1024/apps/insomnia.png \
		/usr/share/pixmaps/insomnia.png

	domenu usr/share/applications/insomnia.desktop

	insinto /opt/Insomnia
	doins -r opt/Insomnia/.
	fperms +x /opt/Insomnia/chrome{-sandbox,_crashpad_handler} \
		/opt/Insomnia/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/Insomnia/libvulkan.so.1 /opt/Insomnia/insomnia
	dosym ../Insomnia/insomnia opt/bin/insomnia

	pax-mark -m "${ED}"/opt/Insomnia/insomnia
}

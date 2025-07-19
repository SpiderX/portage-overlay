# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi
	fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro
	ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
MULTILIB_COMPAT=( abi_x86_64 )

inherit chromium-2 desktop multilib-build pax-utils unpacker xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Database manager for MySQL, PostgreSQL, SQL Server and MongoDB"
HOMEPAGE="https://github.com/dbgate/dbgate"
SRC_URI="https://github.com/dbgate/${MY_PN}/releases/download/v${PV}/${MY_PN}-${PV}-linux_amd64.deb"
S="${WORKDIR}"

LICENSE="MIT"
SLOT=0
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64 suid"
RESTRICT="bindist mirror splitdebug"

RDEPEND="app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	dev-libs/expat[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/libffi:0[${MULTILIB_USEDEP}]
	dev-libs/nspr[${MULTILIB_USEDEP}]
	dev-libs/nss[${MULTILIB_USEDEP}]
	dev-libs/libpcre2:0[${MULTILIB_USEDEP}]
	media-libs/alsa-lib[${MULTILIB_USEDEP}]
	media-libs/mesa[${MULTILIB_USEDEP}]
	net-print/cups[${MULTILIB_USEDEP}]
	sys-apps/dbus[${MULTILIB_USEDEP}]
	sys-apps/util-linux[${MULTILIB_USEDEP}]
	sys-libs/zlib:0[${MULTILIB_USEDEP}]
	x11-libs/cairo[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libdrm[${MULTILIB_USEDEP}]
	x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libXau[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite[${MULTILIB_USEDEP}]
	x11-libs/libXcursor[${MULTILIB_USEDEP}]
	x11-libs/libXdamage[${MULTILIB_USEDEP}]
	x11-libs/libXdmcp[${MULTILIB_USEDEP}]
	x11-libs/libXext[${MULTILIB_USEDEP}]
	x11-libs/libXfixes[${MULTILIB_USEDEP}]
	x11-libs/libXi[${MULTILIB_USEDEP}]
	x11-libs/libXrandr[${MULTILIB_USEDEP}]
	x11-libs/libXrender[${MULTILIB_USEDEP}]
	x11-libs/libXtst[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]"

src_prepare() {
	default
	pushd opt/DbGate/locales || die "pushd failed"
	chromium_remove_language_paks
	popd || die "popd failed"

	if ! use suid ; then
		rm opt/DbGate/chrome-sandbox || die "rm failed"
	fi
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
	fperms -R +x /opt/DbGate/dbgate /opt/DbGate/chrome_crashpad_handler \
		/opt/DbGate/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/DbGate/libvulkan.so.1 \
		/opt/DbGate/resources/app.asar.unpacked/node_modules/better-sqlite3/build/Release/better_sqlite3.node
	use suid && fperms u+s,+x /opt/DbGate/chrome-sandbox

	dosym ../../opt/DbGate/dbgate /usr/bin/dbgate

	pax-mark -m "${ED}"/opt/DbGate/dbgate
}

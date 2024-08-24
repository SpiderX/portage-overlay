# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi fr
	gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru
	sk sl sr sv sw ta te th tr uk vi zh-CN zh-TW"
MULTILIB_COMPAT=( abi_x86_64 )

inherit chromium-2 desktop multilib-build pax-utils unpacker xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="SQL client for MySQL, Postgres, SQLite, SQL Server, and more"
HOMEPAGE="https://www.beekeeperstudio.io"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/releases/download/v${PV}/${MY_PN}_${PV}_amd64.deb"
S="${WORKDIR}"

LICENSE="GPL-3+"
SLOT="0"
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
	net-print/cups[${MULTILIB_USEDEP}]
	sys-apps/dbus[${MULTILIB_USEDEP}]
	sys-apps/util-linux[${MULTILIB_USEDEP}]
	sys-libs/zlib:0[${MULTILIB_USEDEP}]
	x11-libs/cairo[${MULTILIB_USEDEP}]
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
	x11-libs/libxkbcommon[${MULTILIB_USEDEP}]
	x11-libs/libXrandr[${MULTILIB_USEDEP}]
	x11-libs/libXtst[${MULTILIB_USEDEP}]
	x11-libs/pango[${MULTILIB_USEDEP}]"

pkg_pretend() {
	use suid || chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default
	pushd opt/"Beekeeper Studio"/locales || die "pushd failed"
	chromium_remove_language_paks
	popd || die "popd failed"

	sed -i  -e '/Exec/s|Beekeeper Studio|beekeeper-studio|' \
		-e '/MimeType/s|application/vnd.sqlite3;||2g' \
		usr/share/applications/beekeeper-studio.desktop \
		|| die "sed failed for arctype.desktop"

	if ! use suid ; then
		rm opt/"Beekeeper Studio"/chrome-sandbox || die "rm failed"
	fi
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
		/opt/beekeeper-studio/chrome_crashpad_handler \
		/opt/beekeeper-studio/lib{EGL,GLESv2,ffmpeg,vk_swiftshader}.so \
		/opt/beekeeper-studio/libvulkan.so.1 /opt/beekeeper-studio/swiftshader
	use suid && fperms u+s,+x /opt/beekeeper-studio/chrome-sandbox

	dosym ../beekeeper-studio/beekeeper-studio-bin opt/bin/beekeeper-studio

	pax-mark -m "${ED}"/opt/beekeeper-studio/beekeeper-studio-bin
}

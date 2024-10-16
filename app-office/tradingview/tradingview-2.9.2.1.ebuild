# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi fr
	gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru
	sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
MULTILIB_COMPAT=( abi_x86_64 )

inherit chromium-2 desktop pax-utils multilib-build optfeature unpacker xdg

DESCRIPTION="A charting platform for traders and investors"
HOMEPAGE="https://www.tradingview.com/desktop/"
SRC_URI="https://tvd-packages.${PN}.com/ubuntu/stable/pool/multiverse/t/${PN}/jammy/${PN}-$(ver_rs 3 '-')_amd64.deb"
S="${WORKDIR}"

LICENSE="TradingView"
SLOT=0
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64 appindicator suid"
RESTRICT="bindist mirror splitdebug strip"

RDEPEND="app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/mesa:0[${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libdrm:0[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite:0[${MULTILIB_USEDEP}]
	x11-libs/libXdamage:0[${MULTILIB_USEDEP}]
	x11-libs/libXext:0[${MULTILIB_USEDEP}]
	x11-libs/libXfixes:0[${MULTILIB_USEDEP}]
	x11-libs/libxkbcommon:0[${MULTILIB_USEDEP}]
	x11-libs/libxkbfile:0[${MULTILIB_USEDEP}]
	x11-libs/libXrandr:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]
	appindicator? ( dev-libs/libayatana-indicator:3 )"

pkg_pretend() {
	use suid || chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default
	pushd opt/TradingView/locales || die "pushd failed"
	chromium_remove_language_paks
	popd || die "popd failed"

	# don't install licenses
	rm opt/TradingView/LICENSE{S.chromium.html,.electron.txt} \
		|| die "rm failed for licenses"

	if ! use suid ; then
		rm opt/TradingView/chrome-sandbox || die "rm failed"
	fi
}

src_install() {
	doicon -s 512 usr/share/icons/hicolor/512x512/apps/tradingview.png
	dosym ../icons/hicolor/512x512/apps/tradingview.png \
		/usr/share/pixmaps/tradingview.png

	domenu usr/share/applications/tradingview.desktop

	insinto /opt
	doins -r opt/TradingView
	fperms +x /opt/TradingView/{chrome_crashpad_handler,tradingview} \
		/opt/TradingView/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/TradingView/libvulkan.so.1
	use suid && fperms u+s,+x /opt/TradingView/chrome-sandbox

	dosym ../../opt/TradingView/tradingview usr/bin/tradingview

	pax-mark -m "${ED}"/opt/TradingView/tradingview
}

pkg_postinst() {
	optfeature "storing passwords via Secret Service API provider" virtual/secret-service
	xdg_pkg_postinst
}

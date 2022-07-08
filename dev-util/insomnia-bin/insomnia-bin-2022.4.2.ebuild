# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop multilib-build pax-utils unpacker xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="HTTP and GraphQL client for developers"
HOMEPAGE="https://insomnia.rest"
SRC_URI="https://github.com/Kong/${MY_PN}/releases/download/core@${PV}/Insomnia.Core-${PV}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
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
	x11-libs/libdrm:0[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite:0[${MULTILIB_USEDEP}]
	x11-libs/libXdamage:0[${MULTILIB_USEDEP}]
	x11-libs/libXext:0[${MULTILIB_USEDEP}]
	x11-libs/libXfixes:0[${MULTILIB_USEDEP}]
	x11-libs/libxkbcommon:0[${MULTILIB_USEDEP}]
	x11-libs/libXrandr:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]
	appindicator? ( dev-libs/libappindicator:3[${MULTILIB_USEDEP}] )"

QA_FLAGS_IGNORED="opt/Insomnia/libEGL.so
	opt/Insomnia/chrome_crashpad_handler
	opt/Insomnia/libvk_swiftshader.so
	opt/Insomnia/chrome-sandbox
	opt/Insomnia/swiftshader/libEGL.so
	opt/Insomnia/swiftshader/libGLESv2.so
	opt/Insomnia/insomnia
	opt/Insomnia/libGLESv2.so
	opt/Insomnia/libffmpeg.so
	opt/Insomnia/libvulkan.so.1"

S="${WORKDIR}"

src_prepare() {
	default

	if use appindicator ; then
		sed -i '/Exec/s|=|=env XDG_CURRENT_DESKTOP=Unity |' \
			usr/share/applications/insomnia.desktop \
			|| die "sed failed for insomnia.desktop"
	fi
}

src_install() {
	for size in 16 32 48 128 256 512 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}x${size}"/apps/insomnia.png
	done
	dosym ../icons/hicolor/512x512/apps/insomnia.png \
		/usr/share/pixmaps/insomnia.png

	domenu usr/share/applications/insomnia.desktop

	insinto /opt/Insomnia
	doins -r opt/Insomnia/.
	fperms +x /opt/Insomnia/chrome{-sandbox,_crashpad_handler} \
		/opt/Insomnia/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/Insomnia/libvulkan.so.1 /opt/Insomnia/insomnia \
		/opt/Insomnia/swiftshader/lib{EGL,GLESv2}.so
	dosym ../Insomnia/insomnia opt/bin/insomnia

	pax-mark -m "${ED}"/opt/Insomnia/insomnia
}

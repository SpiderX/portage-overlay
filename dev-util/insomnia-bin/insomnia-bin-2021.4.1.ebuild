# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-bin/}"
MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop multilib-build pax-utils unpacker xdg

DESCRIPTION="HTTP and GraphQL client for developers"
HOMEPAGE="https://insomnia.rest"
SRC_URI="https://github.com/Kong/${MY_PN}/releases/download/core@${PV}/Insomnia.Core-${PV}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64 appindicator"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-atk:2[${MULTILIB_USEDEP}]
	dev-libs/atk:0[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/fontconfig:1.0[${MULTILIB_USEDEP}]
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

QA_PREBUILT="opt/Insomnia/insomnia
	opt/Insomnia/libffmpeg.so
	opt/Insomnia/libEGL.so
	opt/Insomnia/libGLESv2.so
	opt/Insomnia/libvk_swiftshader.so
	opt/Insomnia/swiftshader/libGLESv2.so
	opt/Insomnia/swiftshader/libEGL.so
	opt/Insomnia/libvulkan.so
	opt/Insomnia/chrome-sandbox"

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
	for size in 16x16 32x32 48x48 128x128 256x256 512x512 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}"/apps/insomnia.png
	done
	dosym ../icons/hicolor/512x512/apps/insomnia.png \
		/usr/share/pixmaps/insomnia.png

	domenu usr/share/applications/insomnia.desktop

	insinto /opt/Insomnia
	doins -r opt/Insomnia/.
	fperms +x /opt/Insomnia/insomnia opt/Insomnia/chrome-sandbox \
		/opt/Insomnia/swiftshader/lib{EGL,GLESv2}.so \
		/opt/Insomnia/lib{EGL,ffmpeg,GLESv2,vk_swiftshader,vulkan}.so
	dosym ../Insomnia/insomnia opt/bin/insomnia

	pax-mark -m "${ED}"/opt/Insomnia/insomnia
}

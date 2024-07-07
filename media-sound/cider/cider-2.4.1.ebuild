# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop optfeature pax-utils unpacker xdg

DESCRIPTION="A new cross-platform Apple Music experience based on Electron"
HOMEPAGE="https://cider.sh"
SRC_URI="Cider-linux-debian-x64.deb"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="appindicator"
RESTRICT="bindist fetch mirror"

RDEPEND="app-accessibility/at-spi2-core:2
	dev-libs/expat:0
	dev-libs/glib:2
	dev-libs/nspr:0
	dev-libs/nss:0
	media-libs/mesa:0
	net-print/cups:0
	sys-apps/dbus:0
	x11-libs/cairo:0
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb:=
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/pango
	appindicator? ( dev-libs/libayatana-appindicator )"

QA_PREBUILT="opt/Cider/chrome-sandbox
	opt/Cider/chrome_crashpad_handler
	opt/Cider/libEGL.so
	opt/Cider/libGLESv2.so
	opt/Cider/libffmpeg.so
	opt/Cider/libvk_swiftshader.so
	opt/Cider/libvulkan.so.1
	opt/Cider/cider"

pkg_nofetch() {
	einfo "Please download Cider-linux-debian-x64.deb from"
	einfo "${HOMEPAGE}"
	einfo "and place it into your DISTDIR directory"
}

src_install() {
	for size in 16x16 32x32 48x48 64x64 128x128 256x256 512x512 1024x1024 ; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}"/apps/cider.png
	done
	dosym ../icons/hicolor/1024x1024/apps/cider.png \
		/usr/share/pixmaps/cider.png

	domenu usr/share/applications/cider.desktop

	insinto /opt/Cider
	doins -r opt/Cider/.
	fperms -R +x /opt/Cider/cider /opt/Cider/chrome-sandbox /opt/Cider/chrome_crashpad_handler \
		/opt/Cider/libEGL.so /opt/Cider/libGLESv2.so /opt/Cider/libffmpeg.so \
		/opt/Cider/libvk_swiftshader.so /opt/Cider/libvulkan.so.1
	dosym ../Cider/cider opt/bin/cider

	pax-mark -m "${ED}"/opt/Cider/cider
}

pkg_postinst() {
	optfeature "storing passwords via gnome-keyring" app-crypt/libsecret

	xdg_pkg_postinst
}

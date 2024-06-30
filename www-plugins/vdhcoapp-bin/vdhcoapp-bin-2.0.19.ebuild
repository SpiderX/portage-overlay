# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MULTILIB_COMPAT=( abi_x86_{32,64} )

inherit multilib-build pax-utils unpacker

MY_PN="${PN/-bin/}"

DESCRIPTION="Companion application for Video DownloadHelper browser add-on"
HOMEPAGE="https://github.com/aclap-dev/vdhcoapp"
SRC_URI="amd64? ( https://github.com/aclap-dev/${MY_PN}/releases/download/v${PV}/vdhcoapp-linux-x86_64.deb
		-> vdhcoapp-${PV}-x86_64.deb )
	x86? ( https://github.com/aclap-dev/${MY_PN}/releases/download/v${PV}/vdhcoapp-linux-i686.deb
		-> vdhcoapp-${PV}-i686.deb )"
S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="+abi_x86_64"
RESTRICT="bindist mirror strip"

RDEPEND="dev-libs/glib:2[${MULTILIB_USEDEP}]
	media-video/ffmpeg:=[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]"

QA_PREBUILT="opt/vdhcoapp/filepicker
	opt/vdhcoapp/vdhcoapp"

src_install() {
	keepdir /etc/chromium/native-messaging-hosts \
		/etc/opt/chrome/native-messaging-hosts \
		/usr/lib/mozilla/native-messaging-hosts

	exeinto /opt/vdhcoapp
	doexe opt/vdhcoapp/{filepicker,vdhcoapp,xdg-open}
	dosym ../../usr/bin/ffmpeg opt/vdhcoapp/ffmpeg
	dosym ../../usr/bin/ffplay opt/vdhcoapp/ffplay
	dosym ../../usr/bin/ffprobe opt/vdhcoapp/ffprobe

	dodir /opt/bin
	dosym ../vdhcoapp/vdhcoapp opt/bin/vdhcoapp

	pax-mark -m "${ED}"/opt/vdhcoapp/vdhcoapp
}

pkg_postinst() {
	/opt/bin/vdhcoapp install --system || die "install failed"
}

pkg_prerm() {
	/opt/bin/vdhcoapp uninstall --system || die "uninstall failed"
}

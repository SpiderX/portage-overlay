# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MULTILIB_COMPAT=( abi_x86_{32,64} )
MY_PN="${PN/-bin/}"

inherit multilib-build pax-utils unpacker

DESCRIPTION="Companion application for Video DownloadHelper browser add-on"
HOMEPAGE="https://github.com/mi-g/vdhcoapp"
SRC_URI="
	amd64? ( https://github.com/mi-g/${MY_PN}/releases/download/v${PV}/net.downloadhelper.coapp-${PV}-1_amd64.deb )
	x86? ( https://github.com/mi-g/${MY_PN}/releases/download/v${PV}/net.downloadhelper.coapp-${PV}-1_i386.deb )"

LICENSE="GPL-2"
KEYWORDS="-* ~amd64 ~x86"
SLOT="0"
IUSE="+abi_x86_64"
RESTRICT="bindist mirror strip"

RDEPEND="media-video/ffmpeg:=[${MULTILIB_USEDEP}]"

S="${WORKDIR}"

QA_PREBUILT="opt/net.downloadhelper.coapp/bin/net.downloadhelper.coapp-linux-64"
QA_FLAGS_IGNORED="opt/net.downloadhelper.coapp/bin/net.downloadhelper.coapp-linux-64"

src_install() {
	local arch
	arch="$(usex amd64 "64" "32")"

	insinto /etc/chromium/native-messaging-hosts
	doins etc/chromium/native-messaging-hosts/net.downloadhelper.coapp.json
	insinto /etc/opt/chrome/native-messaging-hosts
	doins etc/opt/chrome/native-messaging-hosts/net.downloadhelper.coapp.json
	insinto /usr/lib/mozilla/native-messaging-hosts
	doins usr/lib/mozilla/native-messaging-hosts/net.downloadhelper.coapp.json
	insinto /opt/net.downloadhelper.coapp
	doins opt/net.downloadhelper.coapp/config.json
	exeinto /opt/net.downloadhelper.coapp/bin
	doexe opt/net.downloadhelper.coapp/bin/{net.downloadhelper.coapp-linux-"${arch}",xdg-open}
	dodir /opt/net.downloadhelper.coapp/converter/build/linux/"${arch}"
	dosym ../../../../../../usr/bin/ffmpeg \
		opt/net.downloadhelper.coapp/converter/build/linux/"${arch}"/ffmpeg
	dosym ../../../../../../usr/bin/ffplay \
		opt/net.downloadhelper.coapp/converter/build/linux/"${arch}"/ffplay
	dosym ../../../../../../usr/bin/ffprobe \
		opt/net.downloadhelper.coapp/converter/build/linux/"${arch}"/ffprobe

	dodir /opt/bin
	dosym ../net.downloadhelper.coapp/bin/net.downloadhelper.coapp-linux-"${arch}" \
		opt/bin/net.downloadhelper.coapp-linux-"${arch}"

	pax-mark -m "${ED}"/opt/net.downloadhelper.coapp/bin/net.downloadhelper.coapp-linux-"${arch}"
}

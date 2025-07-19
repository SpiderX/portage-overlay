# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi
	fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro
	ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
MULTILIB_COMPAT=( abi_x86_64 )

inherit chromium-2 desktop multilib-build pax-utils unpacker xdg

DESCRIPTION="The MongoDB GUI"
HOMEPAGE="https://github.com/mongodb-js/compass"
SRC_URI="https://github.com/mongodb-js/compass/releases/download/v${PV}/${P/%-${PV}/_${PV}}_amd64.deb"
S="${WORKDIR}"

LICENSE="SSPL-1"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64 suid"
RESTRICT="bindist mirror splitdebug"

RDEPEND="app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	app-crypt/libsecret[${MULTILIB_USEDEP}]
	app-crypt/mit-krb5[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/libffi:0[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	dev-libs/libpcre2:0[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/mesa:0[vulkan,${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	sys-apps/util-linux[${MULTILIB_USEDEP}]
	sys-libs/zlib:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libdrm:0[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/libXau[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite:0[${MULTILIB_USEDEP}]
	x11-libs/libXdamage:0[${MULTILIB_USEDEP}]
	x11-libs/libXdmcp[${MULTILIB_USEDEP}]
	x11-libs/libXext:0[${MULTILIB_USEDEP}]
	x11-libs/libXfixes:0[${MULTILIB_USEDEP}]
	x11-libs/libxkbcommon:0[${MULTILIB_USEDEP}]
	x11-libs/libXrandr:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]"

QA_PREBUILT="/opt/mongodb-compass/resources/app.asar.unpacked/node_modules/mongodb-client-encryption/build/Release/mongocrypt.node"

pkg_pretend() {
	use suid || chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default
	pushd usr/lib/mongodb-compass/locales || die "pushd failed"
	chromium_remove_language_paks
	popd || die "popd failed"

	rm usr/lib/mongodb-compass/{LICENSES.chromium.html,THIRD-PARTY-NOTICES.md} \
		|| die "rm licenses failed"

	# don't produce logs
	sed -i '/Exec/s|=|=env MONGODB_COMPASS_TEST_LOG_DIR=/dev/null |' \
		usr/share/applications/mongodb-compass.desktop \
		|| die "sed failed for mongodb-compass.desktop"

	if ! use suid ; then
		rm usr/lib/mongodb-compass/chrome-sandbox || die "rm failed"
	fi
}

src_install() {
	doicon usr/share/pixmaps/mongodb-compass.png
	doicon -s 256 usr/share/pixmaps/mongodb-compass.png
	domenu usr/share/applications/mongodb-compass.desktop

	insinto /opt
	doins -r usr/lib/mongodb-compass
	fperms +x /opt/mongodb-compass/'MongoDB Compass' \
		/opt/mongodb-compass/chrome_crashpad_handler \
		/opt/mongodb-compass/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/mongodb-compass/libvulkan.so.1 \
		/opt/mongodb-compass/resources/app.asar.unpacked/node_modules/interruptor/{bin/linux-x64-123,build/Release,build/Release/obj.target}/interruptor.node \
		/opt/mongodb-compass/resources/app.asar.unpacked/node_modules/kerberos/{bin/linux-x64-123,build/Release,build/Release/obj.target}/kerberos.node \
		/opt/mongodb-compass/resources/app.asar.unpacked/node_modules/keytar/{bin/linux-x64-123,build/Release,build/Release/obj.target}/keytar.node \
		/opt/mongodb-compass/resources/app.asar.unpacked/node_modules/mongodb-client-encryption/build/Release/mongocrypt.node \
		/opt/mongodb-compass/resources/app.asar.unpacked/node_modules/os-dns-native/bin/linux-x64-123/os-dns-native.node \
		/opt/mongodb-compass/resources/app.asar.unpacked/node_modules/os-dns-native/{build/Release,build/Release/obj.target}/os_dns_native.node
	use suid && fperms u+s,+x /opt/mongodb-compass/chrome-sandbox

	dosym ../../opt/mongodb-compass/'MongoDB Compass' usr/bin/mongodb-compass

	pax-mark -m "${ED}"/opt/mongodb-compass/'MongoDB Compass'
}

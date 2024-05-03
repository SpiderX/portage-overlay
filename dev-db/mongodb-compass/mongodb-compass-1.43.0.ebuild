# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop multilib-build pax-utils unpacker xdg

DESCRIPTION="The MongoDB GUI"
HOMEPAGE="https://github.com/mongodb-js/compass"
SRC_URI="https://github.com/mongodb-js/compass/releases/download/v${PV}/${P/%-${PV}/_${PV}}_amd64.deb"
S="${WORKDIR}"

LICENSE="SSPL-1"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	app-crypt/libsecret:0[${MULTILIB_USEDEP}]
	app-crypt/mit-krb5[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/mesa:0[${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
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
	x11-libs/pango:0[${MULTILIB_USEDEP}]"

QA_PREBUILT="opt/mongodb-compass/MongoDB*
	opt/mongodb-compass/chrome_crashpad_handler
	opt/mongodb-compass/chrome-sandbox
	opt/mongodb-compass/libEGL.so
	opt/mongodb-compass/libvk_swiftshader.so
	opt/mongodb-compass/libGLESv2.so
	opt/mongodb-compass/libffmpeg.so
	opt/mongodb-compass/libvulkan.so.1
	opt/mongodb-compass/resources/app.asar.unpacked/build/assets/mongo_crypt_v1.b55eb6302dbf1684f29c.so
	opt/mongodb-compass/resources/app.asar.unpacked/build/d9ee7f7ac1af63cacc6971ab72a80c0b.node
	opt/mongodb-compass/resources/app.asar.unpacked/build/286c61484041ddaaa2823191ee8544e3.node
	opt/mongodb-compass/resources/app.asar.unpacked/node_modules/os-dns-native/bin/linux-x64-121/os-dns-native.node
	opt/mongodb-compass/resources/app.asar.unpacked/node_modules/os-dns-native/build/Release/os_dns_native.node
	opt/mongodb-compass/resources/app.asar.unpacked/node_modules/os-dns-native/build/Release/obj.target/os_dns_native.node
	opt/mongodb-compass/resources/app.asar.unpacked/node_modules/kerberos/bin/linux-x64-121/kerberos.node
	opt/mongodb-compass/resources/app.asar.unpacked/node_modules/kerberos/build/Release/kerberos.node
	opt/mongodb-compass/resources/app.asar.unpacked/node_modules/kerberos/build/Release/obj.target/kerberos.node
	opt/mongodb-compass/resources/app.asar.unpacked/node_modules/mongodb-client-encryption/build/Release/mongocrypt.node
	opt/mongodb-compass/resources/app.asar.unpacked/node_modules/keytar/bin/linux-x64-121/keytar.node
	opt/mongodb-compass/resources/app.asar.unpacked/node_modules/keytar/build/Release/keytar.node
	opt/mongodb-compass/resources/app.asar.unpacked/node_modules/keytar/build/Release/obj.target/keytar.node
	opt/mongodb-compass/resources/app.asar.unpacked/node_modules/interruptor/bin/linux-x64-121/interruptor.node
	opt/mongodb-compass/resources/app.asar.unpacked/node_modules/interruptor/build/Release/interruptor.node
	opt/mongodb-compass/resources/app.asar.unpacked/node_modules/interruptor/build/Release/obj.target/interruptor.node"

src_prepare() {
	default

	# don't produce logs
	sed -i '/Exec/s|=|=env MONGODB_COMPASS_TEST_LOG_DIR=/dev/null |' \
		usr/share/applications/mongodb-compass.desktop \
		|| die "sed failed for mongodb-compass.desktop"

	rm usr/lib/mongodb-compass/LICENSES.chromium.html \
		|| die "rm licenses failed"
}

src_install() {
	doicon usr/share/pixmaps/mongodb-compass.png
	doicon -s 256 usr/share/pixmaps/mongodb-compass.png
	domenu usr/share/applications/mongodb-compass.desktop

	insinto /opt
	cp -a usr/lib/mongodb-compass "${ED}"/opt || die "cp failed"

	fperms +x /opt/mongodb-compass/'MongoDB Compass' \
		/opt/mongodb-compass/chrome-sandbox \
		/opt/mongodb-compass/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/mongodb-compass/libvulkan.so.1 \
		/opt/mongodb-compass/resources/app.asar.unpacked/node_modules/interruptor/{bin/linux-x64-121,build/Release,build/Release/obj.target}/interruptor.node \
		/opt/mongodb-compass/resources/app.asar.unpacked/node_modules/kerberos/{bin/linux-x64-121,build/Release,build/Release/obj.target}/kerberos.node \
		/opt/mongodb-compass/resources/app.asar.unpacked/node_modules/keytar/{bin/linux-x64-121,build/Release,build/Release/obj.target}/keytar.node \
		/opt/mongodb-compass/resources/app.asar.unpacked/node_modules/mongodb-client-encryption/build/Release/mongocrypt.node \
		/opt/mongodb-compass/resources/app.asar.unpacked/node_modules/os-dns-native/bin/linux-x64-121/os-dns-native.node \
		/opt/mongodb-compass/resources/app.asar.unpacked/node_modules/os-dns-native/{build/Release,build/Release/obj.target}/os_dns_native.node

	dosym ../../opt/mongodb-compass/'MongoDB Compass' usr/bin/mongodb-compass

	pax-mark -m "${ED}"/opt/mongodb-compass/'MongoDB Compass'
}

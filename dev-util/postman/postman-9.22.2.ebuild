# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop multilib-build pax-utils xdg

DESCRIPTION="Build, test, and document your APIs faster"
HOMEPAGE="https://www.postman.com"
SRC_URI="https://dl.pstmn.io/download/version/${PV}/linux64 -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64"
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
	x11-libs/libxshmfence:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]"

QA_FLAGS_IGNORED="opt/postman/libEGL.so
	opt/postman/chrome_crashpad_handler
	opt/postman/Postman
	opt/postman/postman
	opt/postman/libvk_swiftshader.so
	opt/postman/chrome-sandbox
	opt/postman/swiftshader/libEGL.so
	opt/postman/swiftshader/libGLESv2.so
	opt/postman/libGLESv2.so
	opt/postman/libffmpeg.so
	opt/postman/libvulkan.so.1"

S="${WORKDIR}/Postman/app"

src_install() {
	newicon -s 128 resources/app/assets/icon.png postman.png
	dosym ../icons/hicolor/128x128/apps/postman.png \
		/usr/share/pixmaps/postman.png

	insinto /opt/postman
	doins -r .
	fperms +x /opt/postman/chrome{-sandbox,_crashpad_handler} \
		/opt/postman/lib{EGL,ffmpeg,GLESv2,vk_swiftshader}.so \
		/opt/postman/libvulkan.so.1 /opt/postman/{P,p}ostman \
		/opt/postman/swiftshader/lib{EGL,GLESv2}.so \
		/opt/postman/resources/app/node_modules/which/bin/node-which \
		/opt/postman/resources/app/node_modules/uuid/bin/uuid \
		/opt/postman/resources/app/node_modules/uglify-js/bin/uglifyjs \
		/opt/postman/resources/app/node_modules/sshpk/bin/sshpk-{conv,sign,verify} \
		/opt/postman/resources/app/node_modules/shelljs/bin/shjs \
		/opt/postman/resources/app/node_modules/semver/bin/semver \
		/opt/postman/resources/app/node_modules/resolve/bin/resolve \
		/opt/postman/resources/app/node_modules/protobufjs/bin/pb{js,ts} \
		/opt/postman/resources/app/node_modules/postman-runtime/node_modules/uuid/dist/bin/uuid \
		/opt/postman/resources/app/node_modules/postman-collection/node_modules/uuid/dist/bin/uuid \
		/opt/postman/resources/app/node_modules/postman-collection/node_modules/semver/bin/semver.js \
		/opt/postman/resources/app/node_modules/pem/bin/test_build_openssl.sh \
		/opt/postman/resources/app/node_modules/mkdirp/bin/cmd.js \
		/opt/postman/resources/app/node_modules/handlebars/{bin/handlebars,print-script} \
		/opt/postman/resources/app/node_modules/@grpc/proto-loader/build/bin/proto-loader-gen-types.js \
		/opt/postman/resources/app/node_modules/rimraf/bin.js
	dosym ../postman/Postman opt/bin/postman

	pax-mark -m "${ED}"/opt/postman/postman

	make_desktop_entry "postman %U" "Postman" "" "Development;Utility;" \
		"Path=/opt/postman\nStartupNotify=true\nStartupWMClass=postman\nMimeType=x-scheme-handler/postman"
}

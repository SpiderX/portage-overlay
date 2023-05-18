# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"

inherit bash-completion-r1 desktop edo multilib-build pax-utils xdg

DESCRIPTION="Data management tool to work with DW, Azure, SQL Server"
HOMEPAGE="https://github.com/microsoft/azuredatastudio"
SRC_URI="https://azuredatastudio-update.azurewebsites.net/${PV}/linux-x64/stable -> ${P}-x64.tar.gz"

LICENSE="MIT Microsoft-ADS"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="kerberos"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	app-crypt/libsecret
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	dev-util/lttng-ust:0
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/fontconfig:1.0[${MULTILIB_USEDEP}]
	net-misc/curl:0[${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libdrm:0[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/libxcb:0/1.12[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite:0[${MULTILIB_USEDEP}]
	x11-libs/libXcursor:0[${MULTILIB_USEDEP}]
	x11-libs/libXdamage:0[${MULTILIB_USEDEP}]
	x11-libs/libXext:0[${MULTILIB_USEDEP}]
	x11-libs/libXfixes:0[${MULTILIB_USEDEP}]
	x11-libs/libXi:0[${MULTILIB_USEDEP}]
	x11-libs/libxkbfile:0[${MULTILIB_USEDEP}]
	x11-libs/libXrandr:0[${MULTILIB_USEDEP}]
	x11-libs/libXrender:0[${MULTILIB_USEDEP}]
	x11-libs/libXScrnSaver:0[${MULTILIB_USEDEP}]
	x11-libs/libXtst:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]
	virtual/libcrypt:0[${MULTILIB_USEDEP}]
	kerberos? ( virtual/krb5[${MULTILIB_USEDEP}] )"

QA_PREBUILT="opt/azuredatastudio/resources/app/node_modules.asar.unpacked/spdlog/build/Release/spdlog.node
	opt/azuredatastudio/resources/app/node_modules.asar.unpacked/node-pty/build/Release/pty.node
	opt/azuredatastudio/resources/app/node_modules.asar.unpacked/@parcel/watcher/build/Release/watcher.node
	opt/azuredatastudio/resources/app/node_modules.asar.unpacked/native-is-elevated/build/Release/iselevated.node
	opt/azuredatastudio/resources/app/node_modules.asar.unpacked/native-keymap/build/Release/keymapping.node
	opt/azuredatastudio/resources/app/node_modules.asar.unpacked/keytar/build/Release/obj.target/keytar.node
	opt/azuredatastudio/resources/app/node_modules.asar.unpacked/@vscode/sqlite3/build/Release/vscode-sqlite3.node
	opt/azuredatastudio/resources/app/node_modules.asar.unpacked/@vscode/ripgrep/bin/rg
	opt/azuredatastudio/resources/app/node_modules.asar.unpacked/native-watchdog/build/Release/watchdog.node
	opt/azuredatastudio/resources/app/node_modules.asar.unpacked/windows-foreground-love/build/Release/obj.target/foreground_love.node
	opt/azuredatastudio/resources/app/node_modules.asar.unpacked/windows-foreground-love/build/Release/foreground_love.node
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/MicrosoftSqlToolsServiceLayer
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/libclrgc.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/libSystem.Net.Security.Native.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/libcoreclrtraceptprovider.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/libSystem.Security.Cryptography.Native.OpenSsl.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/MicrosoftSqlToolsMigration
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/MicrosoftSqlToolsCredentials
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/MicrosoftKustoServiceLayer
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/libcoreclr.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/System.Native.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/SqlToolsResourceProviderService
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/libmscordaccore.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/libmscordbi.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/libhostpolicy.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/createdump
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/libSystem.Native.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/libhostfxr.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/System.Net.Http.Native.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/System.Security.Cryptography.Native.OpenSsl.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/libSystem.IO.Compression.Native.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/libSystem.Globalization.Native.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/libclrjit.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/4.6.1.4/System.IO.Compression.Native.so
	opt/azuredatastudio/chrome_crashpad_handler
	opt/azuredatastudio/chrome-sandbox
	opt/azuredatastudio/libffmpeg.so
	opt/azuredatastudio/libvulkan.so.1"
QA_FLAGS_IGNORED="opt/azuredatastudio/azuredatastudio
	opt/azuredatastudio/resources/app/node_modules.asar.unpacked/keytar/build/Release/keytar.node
	opt/azuredatastudio/libEGL.so
	opt/azuredatastudio/libvk_swiftshader.so
	opt/azuredatastudio/libGLESv2.so"

S="${WORKDIR}/${MY_PN}-linux-x64"

src_install() {
	insinto /opt/azuredatastudio
	edo cp -a . "${ED}"/opt/azuredatastudio

	dobashcomp resources/completions/bash/azuredatastudio
	insinto /usr/share/zsh/site-functions
	doins resources/completions/zsh/_azuredatastudio

	newicon resources/app/resources/linux/code.png azuredatastudio.png
	newicon -s 512 resources/app/resources/linux/code.png azuredatastudio.png
	domenu "${FILESDIR}"/{azuredatastudio,azuredatastudio-url-handler}.desktop

	dodir /opt/bin
	dosym ../azuredatastudio/bin/azuredatastudio opt/bin/azuredatastudio

	insinto /usr/share/metainfo
	doins "${FILESDIR}"/azuredatastudio.appdata.xml

	pax-mark -m "${ED}"/opt/azuredatastudio/azuredatastudio

	dosym ./liblttng-ust.so.1.0.0 /usr/"$(get_libdir)"/liblttng-ust.so.0
}

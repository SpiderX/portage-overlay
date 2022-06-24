# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"

inherit bash-completion-r1 desktop edo multilib-build optfeature pax-utils xdg

DESCRIPTION="Data management tool to work with DW, Azure, SQL Server"
HOMEPAGE="https://github.com/microsoft/azuredatastudio"
SRC_URI="https://azuredatastudio-update.azurewebsites.net/${PV}/linux-x64/stable -> ${P}-x64.tar.gz"

LICENSE="MIT Microsoft-ADS"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="kerberos"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-atk:2[${MULTILIB_USEDEP}]
	app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	dev-libs/atk:0[${MULTILIB_USEDEP}]
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

QA_PREBUILT="opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/libSystem.Native.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/libdbgshim.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/System.Net.Http.Native.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/MicrosoftSqlToolsCredentials
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/libcoreclr.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/libclrjit.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/System.IO.Compression.Native.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/libhostfxr.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/MicrosoftKustoServiceLayer
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/libSystem.Net.Security.Native.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/createdump
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/libhostpolicy.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/MicrosoftSqlToolsServiceLayer
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/libcoreclrtraceptprovider.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/System.Native.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/System.Security.Cryptography.Native.OpenSsl.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/libmscordaccore.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/libSystem.Security.Cryptography.Native.OpenSsl.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/libmscordbi.so
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/SqlToolsResourceProviderService
	opt/azuredatastudio/resources/app/extensions/mssql/sqltoolsservice/Linux/3.0.0-release.139/libSystem.IO.Compression.Native.so
	opt/azuredatastudio/resources/app/node_modules.asar.unpacked/keytar/build/Release/keytar.node
	opt/azuredatastudio/resources/app/node_modules.asar.unpacked/vscode-ripgrep/bin/rg
	opt/azuredatastudio/azuredatastudio
	opt/azuredatastudio/swiftshader/libEGL.so
	opt/azuredatastudio/swiftshader/libGLESv2.so
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
}

pkg_postinst() {
	optfeature "storing passwords via gnome-keyring" app-crypt/libsecret

	xdg_pkg_postinst
}

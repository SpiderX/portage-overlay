# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi fr
	gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru
	sk sl sr sv sw ta te th tr uk vi zh-CN zh-TW"
MULTILIB_COMPAT=( abi_x86_64 )
PYTHON_COMPAT=( python3_{12..15} )

inherit chromium-2 desktop edo pax-utils python-any-r1 multilib-build unpacker xdg

BUILD="9100000100"

DESCRIPTION="Invest in stocks, ETFs, and options with Webull Financial"
HOMEPAGE="https://www.webull.com/introduce/desktop-native"
SRC_URI="https://u1sweb.webullfintech.com/us/Webull%20Desktop_${PV}_${BUILD}_global_x64signed_g4he6gisr6yp.deb -> ${P}.deb"
S="${WORKDIR}"

LICENSE="Apache-2.0 GPL-3 LGPL-2.1"
SLOT=0
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64"
RESTRICT="bindist mirror splitdebug"

RDEPEND="app-accessibility/at-spi2-core:2[${MULTILIB_USEDEP}]
	app-crypt/mit-krb5[${MULTILIB_USEDEP}]
	app-crypt/p11-kit[${MULTILIB_USEDEP}]
	dev-db/sqlite:3[${MULTILIB_USEDEP}]
	dev-libs/dbus-glib[${MULTILIB_USEDEP}]
	dev-libs/expat:0[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/gmp:0[${MULTILIB_USEDEP}]
	dev-libs/libbsd[${MULTILIB_USEDEP}]
	dev-libs/libgcrypt:0[${MULTILIB_USEDEP}]
	dev-libs/libgpg-error[${MULTILIB_USEDEP}]
	dev-libs/libltdl[${MULTILIB_USEDEP}]
	dev-libs/libtasn1[${MULTILIB_USEDEP}]
	dev-libs/libthai
	dev-libs/libxml2:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	gnome-base/librsvg:2[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/fontconfig:1.0[${MULTILIB_USEDEP}]
	media-libs/freetype:2[${MULTILIB_USEDEP}]
	media-libs/harfbuzz[${MULTILIB_USEDEP}]
	sys-apps/dbus:0[${MULTILIB_USEDEP}]
	sys-libs/libxcrypt[compat,${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
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
	x11-libs/libXrandr:0[${MULTILIB_USEDEP}]
	x11-libs/libXrender:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]"
BDEPEND="dev-util/patchelf
	${PYTHON_DEPS}
	$(python_gen_any_dep 'dev-libs/lief[python,${PYTHON_SINGLE_USEDEP}]')"

QA_PREBUILT="opt/WebullDesktop/libXrender.so.1
	opt/WebullDesktop/libplds4.so
	opt/WebullDesktop/libgssapi.so.3
	opt/WebullDesktop/libwbcommonui.so
	opt/WebullDesktop/libsentry.so
	opt/WebullDesktop/libgme.so.0
	opt/WebullDesktop/libQt5Concurrent.so.5
	opt/WebullDesktop/libxcb-image.so.0
	opt/WebullDesktop/libnspr4.so
	opt/WebullDesktop/libicui18n.so.56
	opt/WebullDesktop/libicui18n.so.74
	opt/WebullDesktop/libcrypt.so.1
	opt/WebullDesktop/libXv.so.1
	opt/WebullDesktop/libFLAC.so.8
	opt/WebullDesktop/libQt5Qml.so.5
	opt/WebullDesktop/libopenal.so.1
	opt/WebullDesktop/libsoftokn3.so
	opt/WebullDesktop/libva.so.2
	opt/WebullDesktop/libXau.so.6
	opt/WebullDesktop/libQtAVWidgets.so.1
	opt/WebullDesktop/libheimntlm.so.0
	opt/WebullDesktop/librsvg-2.so.2
	opt/WebullDesktop/libnettle.so.6
	opt/WebullDesktop/libQt5QuickWidgets.so.5
	opt/WebullDesktop/libopus.so.0
	opt/WebullDesktop/libglib-2.0.so.0
	opt/WebullDesktop/libselinux.so.1
	opt/WebullDesktop/libgmodule-2.0.so.0
	opt/WebullDesktop/libatomic.so.1
	opt/WebullDesktop/libunistring.so.2
	opt/WebullDesktop/libxml2.so.2
	opt/WebullDesktop/libvorbisfile.so.3
	opt/WebullDesktop/libgcrypt.so.20
	opt/WebullDesktop/libpulse.so.0
	opt/WebullDesktop/libQt5Svg.so.5
	opt/WebullDesktop/QtWebEngineProcess
	opt/WebullDesktop/libXfixes.so.3
	opt/WebullDesktop/libcrystalhd.so.3
	opt/WebullDesktop/libffi.so.6
	opt/WebullDesktop/libnsl.so.1
	opt/WebullDesktop/libdatrie.so.1
	opt/WebullDesktop/libdbus-1.so.3
	opt/WebullDesktop/libxcb-xfixes.so.0
	opt/WebullDesktop/libQtAV.so
	opt/WebullDesktop/libwbupdater.so
	opt/WebullDesktop/libkeyutils.so.1
	opt/WebullDesktop/libQtAVWidgets.so
	opt/WebullDesktop/libsmime3.so
	opt/WebullDesktop/libkrb5support.so.0
	opt/WebullDesktop/libQt5OpenGL.so
	opt/WebullDesktop/libnuma.so.1
	opt/WebullDesktop/libspeex.so.1
	opt/WebullDesktop/libXext.so.6
	opt/WebullDesktop/libQt5WebEngineCore.so.5
	opt/WebullDesktop/libQt5Xml.so.5
	opt/WebullDesktop/libicudata.so.56
	opt/WebullDesktop/libJavaScriptCore.so.1
	opt/WebullDesktop/libasn1.so.8
	opt/WebullDesktop/libfreebl3.so
	opt/WebullDesktop/libavcodec.so.57
	opt/WebullDesktop/libvdpau.so.1
	opt/WebullDesktop/libwbrunnerwrapper.so
	opt/WebullDesktop/librtmp.so.1
	opt/WebullDesktop/libx265.so.146
	opt/WebullDesktop/libxcb-xinput.so.0
	opt/WebullDesktop/libheimbase.so.1
	opt/WebullDesktop/libwbmqtt.so
	opt/WebullDesktop/libssh-gcrypt.so.4
	opt/WebullDesktop/libgobject-2.0.so.0
	opt/WebullDesktop/libxcb-shm.so.0
	opt/WebullDesktop/libQt5Widgets.so.5
	opt/WebullDesktop/libQt5OpenGL.so.5
	opt/WebullDesktop/libQt5Quick.so.5
	opt/WebullDesktop/libpangoft2-1.0.so.0
	opt/WebullDesktop/libwbwebviewui.so
	opt/WebullDesktop/libXcomposite.so.1
	opt/WebullDesktop/libQt5Gui.so.5
	opt/WebullDesktop/libQt5SerialPort.so.5
	opt/WebullDesktop/libicuuc.so.74
	opt/WebullDesktop/libsqlite3.so.0
	opt/WebullDesktop/libopenjp2.so.7
	opt/WebullDesktop/libXtst.so.6
	opt/WebullDesktop/libmp3lame.so.0
	opt/WebullDesktop/libQtAV.so.1
	opt/WebullDesktop/libwrap.so.0
	opt/WebullDesktop/libgio-2.0.so.0
	opt/WebullDesktop/libcairo.so.2
	opt/WebullDesktop/liblzma.so.5
	opt/WebullDesktop/libpixman-1.so.0
	opt/WebullDesktop/libxcb-util.so.1
	opt/WebullDesktop/libpsl.so.5
	opt/WebullDesktop/libwbbaseui.so
	opt/WebullDesktop/libtasn1.so.6
	opt/WebullDesktop/libQtAVWidgets.so.1.13
	opt/WebullDesktop/libopenmpt.so.0
	opt/WebullDesktop/libsndfile.so.1
	opt/WebullDesktop/libQt5X11Extras.so.5
	opt/WebullDesktop/WebullDesktop
	opt/WebullDesktop/plugins/imageformats/libqtiff.so
	opt/WebullDesktop/plugins/imageformats/libqwebp.so
	opt/WebullDesktop/plugins/imageformats/libqtga.so
	opt/WebullDesktop/plugins/imageformats/libqwbmp.so
	opt/WebullDesktop/plugins/imageformats/libqicns.so
	opt/WebullDesktop/plugins/imageformats/libqgif.so
	opt/WebullDesktop/plugins/imageformats/libqsvg.so
	opt/WebullDesktop/plugins/imageformats/libqico.so
	opt/WebullDesktop/plugins/imageformats/libqjpeg.so
	opt/WebullDesktop/plugins/platforminputcontexts/libcomposeplatforminputcontextplugin.so
	opt/WebullDesktop/plugins/platforminputcontexts/libibusplatforminputcontextplugin.so
	opt/WebullDesktop/plugins/plugins/imageformats/libqtiff.so
	opt/WebullDesktop/plugins/plugins/imageformats/libqwebp.so
	opt/WebullDesktop/plugins/plugins/imageformats/libqtga.so
	opt/WebullDesktop/plugins/plugins/imageformats/libqwbmp.so
	opt/WebullDesktop/plugins/plugins/imageformats/libqicns.so
	opt/WebullDesktop/plugins/plugins/imageformats/libqgif.so
	opt/WebullDesktop/plugins/plugins/imageformats/libqsvg.so
	opt/WebullDesktop/plugins/plugins/imageformats/libqico.so
	opt/WebullDesktop/plugins/plugins/imageformats/libqjpeg.so
	opt/WebullDesktop/plugins/plugins/platforminputcontexts/libcomposeplatforminputcontextplugin.so
	opt/WebullDesktop/plugins/plugins/platforminputcontexts/libibusplatforminputcontextplugin.so
	opt/WebullDesktop/plugins/plugins/position/libqtposition_serialnmea.so
	opt/WebullDesktop/plugins/plugins/position/libqtposition_geoclue.so
	opt/WebullDesktop/plugins/plugins/position/libqtposition_positionpoll.so
	opt/WebullDesktop/plugins/plugins/position/libqtposition_geoclue2.so
	opt/WebullDesktop/plugins/plugins/xcbglintegrations/libqxcb-glx-integration.so
	opt/WebullDesktop/plugins/plugins/xcbglintegrations/libqxcb-egl-integration.so
	opt/WebullDesktop/plugins/plugins/bearer/libqconnmanbearer.so
	opt/WebullDesktop/plugins/plugins/bearer/libqnmbearer.so
	opt/WebullDesktop/plugins/plugins/bearer/libqgenericbearer.so
	opt/WebullDesktop/plugins/plugins/iconengines/libqsvgicon.so
	opt/WebullDesktop/plugins/plugins/sqldrivers/libqsqlodbc.so
	opt/WebullDesktop/plugins/plugins/sqldrivers/libqsqlpsql.so
	opt/WebullDesktop/plugins/plugins/sqldrivers/libqsqlite.so
	opt/WebullDesktop/plugins/plugins/platforms/libqxcb.so
	opt/WebullDesktop/plugins/plugins/printsupport/libcupsprintersupport.so
	opt/WebullDesktop/plugins/position/libqtposition_serialnmea.so
	opt/WebullDesktop/plugins/position/libqtposition_geoclue.so
	opt/WebullDesktop/plugins/position/libqtposition_positionpoll.so
	opt/WebullDesktop/plugins/position/libqtposition_geoclue2.so
	opt/WebullDesktop/plugins/xcbglintegrations/libqxcb-glx-integration.so
	opt/WebullDesktop/plugins/xcbglintegrations/libqxcb-egl-integration.so
	opt/WebullDesktop/plugins/bearer/libqconnmanbearer.so
	opt/WebullDesktop/plugins/bearer/libqnmbearer.so
	opt/WebullDesktop/plugins/bearer/libqgenericbearer.so
	opt/WebullDesktop/plugins/iconengines/libqsvgicon.so
	opt/WebullDesktop/plugins/sqldrivers/libqsqlodbc.so
	opt/WebullDesktop/plugins/sqldrivers/libqsqlpsql.so
	opt/WebullDesktop/plugins/sqldrivers/libqsqlite.so
	opt/WebullDesktop/plugins/platforms/libqxcb.so
	opt/WebullDesktop/plugins/printsupport/libcupsprintersupport.so
	opt/WebullDesktop/libpango-1.0.so.0
	opt/WebullDesktop/libcurl.so.4
	opt/WebullDesktop/libicudata.so
	opt/WebullDesktop/libXi.so.6
	opt/WebullDesktop/libxcb-render.so.0
	opt/WebullDesktop/libwind.so.0
	opt/WebullDesktop/libbluray.so.2
	opt/WebullDesktop/libssl.so.1.1
	opt/WebullDesktop/libzvbi.so.0
	opt/WebullDesktop/libQt5Core.so.5
	opt/WebullDesktop/libva-x11.so.2
	opt/WebullDesktop/libkrb5.so.26
	opt/WebullDesktop/libquazip1-qt5.1.4.so
	opt/WebullDesktop/libx264.so.152
	opt/WebullDesktop/libicudata.so.74.2
	opt/WebullDesktop/libva-drm.so.2
	opt/WebullDesktop/libFcitxQt5DBusAddons.so.1
	opt/WebullDesktop/libtheoraenc.so.1
	opt/WebullDesktop/libwbhttpsclient.so
	opt/WebullDesktop/libxcb-randr.so.0
	opt/WebullDesktop/libwbstorecommon.so
	opt/WebullDesktop/libxcb-icccm.so.4
	opt/WebullDesktop/libxcb-xinerama.so.0
	opt/WebullDesktop/libxcb-sync.so.1
	opt/WebullDesktop/libxkbcommon-x11.so.0
	opt/WebullDesktop/libldap_r-2.4.so.2
	opt/WebullDesktop/libsasl2.so.2
	opt/WebullDesktop/libwbbasestore.so
	opt/WebullDesktop/libkrb5.so.3
	opt/WebullDesktop/libwebpmux.so.3
	opt/WebullDesktop/libk5crypto.so.3
	opt/WebullDesktop/libtwolame.so.0
	opt/WebullDesktop/libcrypto.so.1.1
	opt/WebullDesktop/libsnappy.so.1
	opt/WebullDesktop/libpangocairo-1.0.so.0
	opt/WebullDesktop/libasyncns.so.0
	opt/WebullDesktop/libgomp.so.1
	opt/WebullDesktop/libblkid.so.1
	opt/WebullDesktop/libXdmcp.so.6
	opt/WebullDesktop/libswresample.so.2
	opt/WebullDesktop/libswscale.so.4
	opt/WebullDesktop/libicudata.so.74
	opt/WebullDesktop/libavahi-client.so.3
	opt/WebullDesktop/libQt5PrintSupport.so.5
	opt/WebullDesktop/libcrypto.so.1.0.0
	opt/WebullDesktop/libsystemd.so.0
	opt/WebullDesktop/libgsm.so.1
	opt/WebullDesktop/libmpg123.so.0
	opt/WebullDesktop/libwbgrpc.so
	opt/WebullDesktop/libQtAV.so.1.13
	opt/WebullDesktop/libavutil.so.55
	opt/WebullDesktop/libbullscript_c.so
	opt/WebullDesktop/libpng16.so.16
	opt/WebullDesktop/libass.so.9
	opt/WebullDesktop/libgssapi_krb5.so.2
	opt/WebullDesktop/libpulsecommon-11.1.so
	opt/WebullDesktop/libwbcharts.so
	opt/WebullDesktop/libapparmor.so.1
	opt/WebullDesktop/libcroco-0.6.so.3
	opt/WebullDesktop/libpcre.so.3
	opt/WebullDesktop/libvorbisenc.so.2
	opt/WebullDesktop/libroken.so.18
	opt/WebullDesktop/libicui18n.so.60
	opt/WebullDesktop/libsoxr.so.0
	opt/WebullDesktop/libQt5Positioning.so.5
	opt/WebullDesktop/libicuuc.so.74.2
	opt/WebullDesktop/libgthread-2.0.so.0
	opt/WebullDesktop/libQt5WebChannel.so.5
	opt/WebullDesktop/platforms/libqxcb.so
	opt/WebullDesktop/libxcb-glx.so.0
	opt/WebullDesktop/libogg.so.0
	opt/WebullDesktop/libbsd.so.0
	opt/WebullDesktop/libavahi-common.so.3
	opt/WebullDesktop/libicuuc.so.56
	opt/WebullDesktop/wbplugins/libpapertrade.so
	opt/WebullDesktop/wbplugins/libtradestore.so
	opt/WebullDesktop/wbplugins/libaccountui.so
	opt/WebullDesktop/wbplugins/libstockui.so
	opt/WebullDesktop/wbplugins/libquantstrategy.so
	opt/WebullDesktop/wbplugins/libusercenterstore.so
	opt/WebullDesktop/wbplugins/libmarketui.so
	opt/WebullDesktop/wbplugins/libsettingsui.so
	opt/WebullDesktop/wbplugins/libalert.so
	opt/WebullDesktop/wbplugins/libaccountbar.so
	opt/WebullDesktop/wbplugins/libcomponentsmanager.so
	opt/WebullDesktop/wbplugins/libstockstore.so
	opt/WebullDesktop/wbplugins/libtradeui.so
	opt/WebullDesktop/wbplugins/libmarketstore.so
	opt/WebullDesktop/wbplugins/libportfoliosui.so
	opt/WebullDesktop/wbplugins/libnetworkdetection.so
	opt/WebullDesktop/wbplugins/libusercenterui.so
	opt/WebullDesktop/wbplugins/libchartsui.so
	opt/WebullDesktop/wbplugins/libusercentermanager.so
	opt/WebullDesktop/libQt5QmlModels.so.5
	opt/WebullDesktop/libnghttp2.so.14
	opt/WebullDesktop/libicui18n.so
	opt/WebullDesktop/libQt5WebEngineWidgets.so.5
	opt/WebullDesktop/libX11-xcb.so.1
	opt/WebullDesktop/libxkbcommon.so.0
	opt/WebullDesktop/libgnutls.so.30_bak
	opt/WebullDesktop/libvorbis.so.0
	opt/WebullDesktop/libJavaScriptCore.so
	opt/WebullDesktop/libsndio.so.6.1
	opt/WebullDesktop/libwbuiframeworkmanager.so
	opt/WebullDesktop/libxcb-shape.so.0
	opt/WebullDesktop/libQt5Network.so.5
	opt/WebullDesktop/libvpx.so.5
	opt/WebullDesktop/libQt5WebSockets.so.5
	opt/WebullDesktop/libchromaprint.so.1
	opt/WebullDesktop/libQt5Sql.so.5
	opt/WebullDesktop/libshine.so.3
	opt/WebullDesktop/libhogweed.so.4
	opt/WebullDesktop/libtheoradec.so.1
	opt/WebullDesktop/libQtAVWidgets.so.1.13.0
	opt/WebullDesktop/libwebp.so.6
	opt/WebullDesktop/libssl.so.1.0.0
	opt/WebullDesktop/libXcursor.so.1
	opt/WebullDesktop/libxvidcore.so.4
	opt/WebullDesktop/libxcb-xkb.so.1
	opt/WebullDesktop/libgraphite2.so.3
	opt/WebullDesktop/libavformat.so.57
	opt/WebullDesktop/libgdk_pixbuf-2.0.so.0
	opt/WebullDesktop/libxcb-render-util.so.0
	opt/WebullDesktop/libidn2.so.0
	opt/WebullDesktop/libmount.so.1
	opt/WebullDesktop/libhx509.so.5
	opt/WebullDesktop/libQt5VirtualKeyboard.so.5
	opt/WebullDesktop/libwavpack.so.1
	opt/WebullDesktop/libicuuc.so.60
	opt/WebullDesktop/libQtAV.so.1.13.0
	opt/WebullDesktop/libwbbasecore.so
	opt/WebullDesktop/libfreeblpriv3.so
	opt/WebullDesktop/libXdamage.so.1
	opt/WebullDesktop/libhcrypto.so.4
	opt/WebullDesktop/libQt5XcbQpa.so.5
	opt/WebullDesktop/liblz4.so.1
	opt/WebullDesktop/libplc4.so
	opt/WebullDesktop/libicuuc.so
	opt/WebullDesktop/libQt5DBus.so.5
	opt/WebullDesktop/libicui18n.so.74.2
	opt/WebullDesktop/libbz2.so.1.0
	opt/WebullDesktop/libicudata.so.60
	opt/WebullDesktop/libxcb-keysyms.so.1
	opt/WebullDesktop/libcups.so.2
	opt/WebullDesktop/liblber-2.4.so.2"

pkg_setup() {
	python-any-r1_pkg_setup
}

src_prepare() {
	default
	edo pushd usr/local/WebullDesktop/locales
	chromium_remove_language_paks
	edo popd
	edo pushd usr/local/WebullDesktop/translations/qtwebengine_locales
	chromium_remove_language_paks
	edo popd

	# don't install licenses
	edo rm usr/local/WebullDesktop/{cronet,jsoncpp,libcef,spdlog,zlib}_LICENSE.txt \
		usr/local/WebullDesktop/{curl_COPYING,finddepends,qtav_lgpl-2.1,xfinddepends}.txt \
		usr/local/WebullDesktop/{grpc,opencc}_apache-2.0.txt \
		usr/local/WebullDesktop/quazip_COPYING

	# fix desktop
	sed -i  -e '/Name/s|Desktop   |Desktop|' \
		-e '/Icon/s|.png||' \
		-e '/Version/d' \
		-e "/Exec/s|=.*$|=env LD_LIBRARY_PATH=\\${LD_LIBRARY_PATH}:/opt/WebullDesktop /opt/WebullDesktop/WebullDesktop|" \
		usr/share/applications/WebullDesktop.desktop

	edo pushd usr/local/WebullDesktop
	# replace GnuTLS-based libcurl with the bundled OpenSSL-based libcurl
	# remove incompatible symbol version requirements.
	"${EPYTHON}" - <<-EOF || die "Failed to patch libwbhttpsclient.so"
		import lief

		elf = lief.ELF.parse("libwbhttpsclient.so")
		assert elf.remove_version_requirement("libcurl-gnutls.so.4")
		elf.remove_library("libcurl-gnutls.so.4")
		elf.add_library("libcurl.so.4")
		elf.write("libwbhttpsclient.so")
	EOF

	# remove bundled libcrypt due to incompatible GLIBC_PRIVATE symbols
	# replace malformed ICU library with the working versioned library
	# to prevent a segmentation fault in the dynamic linker
	edo rm libcrypt.so.1 libicudata.so.74
	edo ln -s libicudata.so.74.2 libicudata.so.74
	edo popd
}

src_install() {
	doicon -s 64 usr/share/icons/hicolor/64x64/apps/WebullDesktop.png
	domenu usr/share/applications/WebullDesktop.desktop

	insinto /opt/WebullDesktop
	doins -r usr/local/WebullDesktop/.
	fperms +x /opt/WebullDesktop/platforms/libqxcb.so \
		/opt/WebullDesktop/plugins/bearer/libq{connmanbearer,genericbearer,nmbearer}.so \
		/opt/WebullDesktop/plugins/iconengines/libqsvgicon.so \
		/opt/WebullDesktop/plugins/imageformats/libq{gif,icns,ico,jpeg,svg,tga,tiff,wbmp,webp}.so \
		/opt/WebullDesktop/plugins/platforminputcontexts/lib{composeplatforminputcontextplugin,ibusplatforminputcontextplugin}.so \
		/opt/WebullDesktop/plugins/platforms/libqxcb.so \
		/opt/WebullDesktop/plugins/position/libqtposition_{geoclue2,geoclue,positionpoll,serialnmea}.so \
		/opt/WebullDesktop/plugins/printsupport/libcupsprintersupport.so \
		/opt/WebullDesktop/plugins/sqldrivers/libqsql{ite,odbc,psql}.so \
		/opt/WebullDesktop/plugins/xcbglintegrations/libqxcb-{egl,glx}-integration.so \
		/opt/WebullDesktop/plugins/plugins/bearer/libq{connmanbearer,genericbearer,nmbearer}.so \
		/opt/WebullDesktop/plugins/plugins/iconengines/libqsvgicon.so \
		/opt/WebullDesktop/plugins/plugins/imageformats/libq{gif,icns,ico,jpeg,svg,tga,tiff,wbmp,webp}.so \
		/opt/WebullDesktop/plugins/plugins/platforminputcontexts/lib{composeplatforminputcontextplugin,ibusplatforminputcontextplugin}.so \
		/opt/WebullDesktop/plugins/plugins/platforms/libqxcb.so \
		/opt/WebullDesktop/plugins/plugins/position/libqtposition_{geoclue2,geoclue,positionpoll,serialnmea}.so \
		/opt/WebullDesktop/plugins/plugins/printsupport/libcupsprintersupport.so \
		/opt/WebullDesktop/plugins/plugins/sqldrivers/libqsql{ite,odbc,psql}.so \
		/opt/WebullDesktop/plugins/plugins/xcbglintegrations/libqxcb-{egl,glx}-integration.so \
		/opt/WebullDesktop/wbplugins/lib{accountbar,alert,componentsmanager,marketui,portfoliosui,stockstore}.so \
		/opt/WebullDesktop/wbplugins/lib{tradestore,usercentermanager,usercenterui,accountui,chartsui,marketstore}.so \
		/opt/WebullDesktop/wbplugins/lib{networkdetection,papertrade,quantstrategy,settingsui,stockui,tradeui,usercenterstore}.so \
		/opt/WebullDesktop/QtWebEngineProcess \
		/opt/WebullDesktop/WebullDesktop \
		/opt/WebullDesktop/libbullscript_c.so \
		/opt/WebullDesktop/libicu{uc,data,i18n}.so.56 \
		/opt/WebullDesktop/libicu{uc,data,i18n}.so.74 \
		/opt/WebullDesktop/libicu{uc,data,i18n}.so.74.2 \
		/opt/WebullDesktop/libJavaScriptCore.so{,.1} \
		/opt/WebullDesktop/libquazip1-qt5.1.4.so \
		/opt/WebullDesktop/lib{Qt5OpenGL,QtAV,QtAVWidgets}.so \
		/opt/WebullDesktop/libQt5{Concurrent,Core,DBus,Gui,Network,OpenGL,Positioning,PrintSupport,QmlModels}.so.5 \
		/opt/WebullDesktop/libQt5{Qml,Quick,QuickWidgets,SerialPort,Sql,Svg,VirtualKeyboard,WebChannel,WebEngineCore}.so.5 \
		/opt/WebullDesktop/libQt5{WebEngineWidgets,WebSockets,Widgets,X11Extras,XcbQpa,Xml}.so.5 \
		/opt/WebullDesktop/libQt5WebSockets.so.5 \
		/opt/WebullDesktop/libQtAV.so{.1,.1.13,.1.13.0} \
		/opt/WebullDesktop/libQtAVWidgets.so{.1,.1.13,.1.13.0} \
		/opt/WebullDesktop/libwb{basecore,basestore,baseui,charts,commonui,grpc,httpsclient,mqtt,storecommon}.so \
		/opt/WebullDesktop/libwb{runnerwrapper,uiframeworkmanager,updater,webviewui}.so

	patchelf --set-rpath "\$ORIGIN" "${ED}"/opt/WebullDesktop/libQtAV.so.1{,.13,.13.0} \
		"${ED}"/opt/WebullDesktop/libQtAVWidgets.so.1{,.13,.13.0} \
		|| die "patchelf failed"

	dosym ../WebullDesktop/WebullDesktop opt/bin/WebullDesktop

	dobin "${FILESDIR}"/webulldesktop

	pax-mark -m "${ED}"/opt/WebullDesktop/WebullDesktop
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2317

EAPI=8

PLOCALES="am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk vi zh-CN zh-TW"
PLOCALE_BACKUP="en-GB"

inherit desktop pax-utils plocale unpacker xdg

BUILD="7001000"

DESCRIPTION="Invest in stocks, ETFs, and options with Webull Financial"
HOMEPAGE="https://www.webull.com/introduce/desktop-native"
SRC_URI="https://u1sweb.webullfintech.com/us/Webull%20Desktop_${PV}_${BUILD}_global_x64signed.deb -> ${P}.deb"
S="${WORKDIR}"

LICENSE="Apache-2.0 GPL-3 LGPL-2.1"
SLOT=0
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="app-accessibility/at-spi2-core:2
	app-crypt/mit-krb5
	app-crypt/p11-kit
	dev-db/sqlite:3
	dev-libs/dbus-glib
	dev-libs/expat:0
	dev-libs/glib:2
	dev-libs/gmp:0
	dev-libs/libbsd
	dev-libs/libgcrypt:0
	dev-libs/libgpg-error
	dev-libs/libltdl
	dev-libs/libtasn1
	dev-libs/libthai
	dev-libs/libxml2:2
	dev-libs/nspr:0
	dev-libs/nss:0
	gnome-base/librsvg:2
	media-libs/alsa-lib:0
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/harfbuzz
	media-video/ffmpeg-compat:57
	sys-apps/dbus:0
	x11-libs/cairo:0
	x11-libs/gtk+:3
	x11-libs/libdrm:0
	x11-libs/libX11:0
	x11-libs/libxcb:0/1.12
	x11-libs/libXcomposite:0
	x11-libs/libXcursor:0
	x11-libs/libXdamage:0
	x11-libs/libXext:0
	x11-libs/libXfixes:0
	x11-libs/libXi:0
	x11-libs/libXrandr:0
	x11-libs/libXrender:0
	x11-libs/pango:0"
BDEPEND="dev-util/patchelf"

QA_PREBUILT="opt/WebullDesktop/QtWebEngineProcess
	opt/WebullDesktop/libwebpmux.so.3
	opt/WebullDesktop/libkrb5.so.3
	opt/WebullDesktop/libffi.so.6
	opt/WebullDesktop/libpixman-1.so.0
	opt/WebullDesktop/libgmodule-2.0.so.0
	opt/WebullDesktop/libtasn1.so.6
	opt/WebullDesktop/libFLAC.so.8
	opt/WebullDesktop/libxcb-xfixes.so.0
	opt/WebullDesktop/libatk-1.0.so.0
	opt/WebullDesktop/libopenmpt.so.0
	opt/WebullDesktop/libX11-xcb.so.1
	opt/WebullDesktop/libicudata.so.60
	opt/WebullDesktop/libva-x11.so.2
	opt/WebullDesktop/libgomp.so.1
	opt/WebullDesktop/libcroco-0.6.so.3
	opt/WebullDesktop/libplc4.so
	opt/WebullDesktop/libavformat.so.57
	opt/WebullDesktop/libsmime3.so
	opt/WebullDesktop/libxcb-keysyms.so.1
	opt/WebullDesktop/libnettle.so.6
	opt/WebullDesktop/libxcb-shm.so.0
	opt/WebullDesktop/libgssapi_krb5.so.2
	opt/WebullDesktop/liblzma.so.5
	opt/WebullDesktop/libx265.so.146
	opt/WebullDesktop/libtheoradec.so.1
	opt/WebullDesktop/libxcb-image.so.0
	opt/WebullDesktop/librtmp.so.1
	opt/WebullDesktop/libwavpack.so.1
	opt/WebullDesktop/libvorbis.so.0
	opt/WebullDesktop/libvorbisenc.so.2
	opt/WebullDesktop/libswresample.so.2
	opt/WebullDesktop/libasyncns.so.0
	opt/WebullDesktop/libXau.so.6
	opt/WebullDesktop/libltdl.so.7
	opt/WebullDesktop/libxcb-sync.so.1
	opt/WebullDesktop/libswscale.so.4
	opt/WebullDesktop/libxvidcore.so.4
	opt/WebullDesktop/libroken.so.18
	opt/WebullDesktop/libhx509.so.5
	opt/WebullDesktop/libcurl.so.4
	opt/WebullDesktop/libdbus-glib-1.so.2
	opt/WebullDesktop/libdbus-1.so.3
	opt/WebullDesktop/libvpx.so.5
	opt/WebullDesktop/libwrap.so.0
	opt/WebullDesktop/libcrystalhd.so.3
	opt/WebullDesktop/libbz2.so.1.0
	opt/WebullDesktop/libk5crypto.so.3
	opt/WebullDesktop/libQtAV.so.1
	opt/WebullDesktop/libXv.so.1
	opt/WebullDesktop/libXext.so.6
	opt/WebullDesktop/libnssckbi.so
	opt/WebullDesktop/libgconf-2.so.4
	opt/WebullDesktop/libcrypto.so.1.1
	opt/WebullDesktop/libicuuc.so.60
	opt/WebullDesktop/libxcb-randr.so.0
	opt/WebullDesktop/libavutil.so.55
	opt/WebullDesktop/libgraphite2.so.3
	opt/WebullDesktop/libQtAV.so.1.13.0
	opt/WebullDesktop/librsvg-2.so.2
	opt/WebullDesktop/libcrypt.so.1
	opt/WebullDesktop/libsoxr.so.0
	opt/WebullDesktop/libxcb-glx.so.0
	opt/WebullDesktop/libgdk_pixbuf-2.0.so.0
	opt/WebullDesktop/libQtAVWidgets.so.1
	opt/WebullDesktop/libtheoraenc.so.1
	opt/WebullDesktop/libXcomposite.so.1
	opt/WebullDesktop/liblz4.so.1
	opt/WebullDesktop/libXrandr.so.2
	opt/WebullDesktop/libkeyutils.so.1
	opt/WebullDesktop/libavcodec.so.57
	opt/WebullDesktop/libxcb-util.so.1
	opt/WebullDesktop/libxcb-xinerama.so.0
	opt/WebullDesktop/libpng16.so.16
	opt/WebullDesktop/libldap_r-2.4.so.2
	opt/WebullDesktop/libblkid.so.1
	opt/WebullDesktop/libhogweed.so.4
	opt/WebullDesktop/libxkbcommon-x11.so.0
	opt/WebullDesktop/libQtAVWidgets.so.1.13
	opt/WebullDesktop/libpango-1.0.so.0
	opt/WebullDesktop/libnsl.so.1
	opt/WebullDesktop/libplds4.so
	opt/WebullDesktop/libopenjp2.so.7
	opt/WebullDesktop/libicui18n.so.56
	opt/WebullDesktop/libgme.so.0
	opt/WebullDesktop/libnspr4.so
	opt/WebullDesktop/libpulsecommon-11.1.so
	opt/WebullDesktop/libwebp.so.6
	opt/WebullDesktop/libgthread-2.0.so.0
	opt/WebullDesktop/libgssapi.so.3
	opt/WebullDesktop/libssl.so.1.1
	opt/WebullDesktop/libavresample.so.3
	opt/WebullDesktop/libwind.so.0
	opt/WebullDesktop/libavahi-client.so.3
	opt/WebullDesktop/libmp3lame.so.0
	opt/WebullDesktop/libopus.so.0
	opt/WebullDesktop/libxcb-icccm.so.4
	opt/WebullDesktop/libpangoft2-1.0.so.0
	opt/WebullDesktop/libxcb-xkb.so.1
	opt/WebullDesktop/libodbc.so.2
	opt/WebullDesktop/libgsm.so.1
	opt/WebullDesktop/libasn1.so.8
	opt/WebullDesktop/libhcrypto.so.4
	opt/WebullDesktop/libxcb-xinput.so.0
	opt/WebullDesktop/libsoftokn3.so
	opt/WebullDesktop/libidn2.so.0
	opt/WebullDesktop/libXrender.so.1
	opt/WebullDesktop/libdatrie.so.1
	opt/WebullDesktop/libnuma.so.1
	opt/WebullDesktop/libsystemd.so.0
	opt/WebullDesktop/libpcre.so.3
	opt/WebullDesktop/libQtAV.so.1.13
	opt/WebullDesktop/libkrb5.so.26
	opt/WebullDesktop/libXi.so.6
	opt/WebullDesktop/libvdpau.so.1
	opt/WebullDesktop/libpangocairo-1.0.so.0
	opt/WebullDesktop/libgdk-x11-2.0.so.0
	opt/WebullDesktop/libgtk-x11-2.0.so.0
	opt/WebullDesktop/libnghttp2.so.14
	opt/WebullDesktop/liblber-2.4.so.2
	opt/WebullDesktop/libicuuc.so.56
	opt/WebullDesktop/libzvbi.so.0
	opt/WebullDesktop/libnss3.so
	opt/WebullDesktop/libpq.so.5
	opt/WebullDesktop/libsqlite3.so.0
	opt/WebullDesktop/libmount.so.1
	opt/WebullDesktop/libogg.so.0
	opt/WebullDesktop/libxkbcommon.so.0
	opt/WebullDesktop/libXss.so.1
	opt/WebullDesktop/libvorbisfile.so.3
	opt/WebullDesktop/libmpg123.so.0
	opt/WebullDesktop/libunistring.so.2
	opt/WebullDesktop/libXcursor.so.1
	opt/WebullDesktop/libxcb-shape.so.0
	opt/WebullDesktop/libXtst.so.6
	opt/WebullDesktop/libxml2.so.2
	opt/WebullDesktop/libQt5WebEngineCore.so.5
	opt/WebullDesktop/libpsl.so.5
	opt/WebullDesktop/libssh-gcrypt.so.4
	opt/WebullDesktop/libpulse.so.0
	opt/WebullDesktop/libQtAVWidgets.so.1.13.0
	opt/WebullDesktop/libQtAV.so
	opt/WebullDesktop/libgcrypt.so.20
	opt/WebullDesktop/libglib-2.0.so.0
	opt/WebullDesktop/libbsd.so.0
	opt/WebullDesktop/libselinux.so.1
	opt/WebullDesktop/libXdmcp.so.6
	opt/WebullDesktop/libxcb-render-util.so.0
	opt/WebullDesktop/libkrb5support.so.0
	opt/WebullDesktop/libgobject-2.0.so.0
	opt/WebullDesktop/libcairo.so.2
	opt/WebullDesktop/libheimntlm.so.0
	opt/WebullDesktop/libchromaprint.so.1
	opt/WebullDesktop/libbluray.so.2
	opt/WebullDesktop/libsndfile.so.1
	opt/WebullDesktop/libXinerama.so.1
	opt/WebullDesktop/libva.so.2
	opt/WebullDesktop/libXfixes.so.3
	opt/WebullDesktop/libsnappy.so.1
	opt/WebullDesktop/libspeex.so.1
	opt/WebullDesktop/libsasl2.so.2
	opt/WebullDesktop/libicui18n.so.60
	opt/WebullDesktop/libapparmor.so.1
	opt/WebullDesktop/libavahi-common.so.3
	opt/WebullDesktop/libgnutls.so.30
	opt/WebullDesktop/libicudata.so.56
	opt/WebullDesktop/libxcb-render.so.0
	opt/WebullDesktop/libx264.so.152
	opt/WebullDesktop/libva-drm.so.2
	opt/WebullDesktop/libcups.so.2
	opt/WebullDesktop/libXdamage.so.1
	opt/WebullDesktop/libjpeg.so.8
	opt/WebullDesktop/libheimbase.so.1
	opt/WebullDesktop/libQtAVWidgets.so
	opt/WebullDesktop/libshine.so.3
	opt/WebullDesktop/libtwolame.so.0
	opt/WebullDesktop/libgio-2.0.so.0"

src_prepare() {
	default

	my_rm_loc() {
		rm usr/local/WebullDesktop/locales/"${1}".pak{,.info} \
			usr/local/WebullDesktop/translations/qtwebengine_locales/"${1}".pak \
			|| die "rm failed for locale ${1}"
	}
	plocale_for_each_disabled_locale my_rm_loc

	# don't install licenses
	rm usr/local/WebullDesktop/{apache-2.0,gpl-3.0,lgpl-2.1,LICENSE}.txt
	# fix desktop
	sed -i  -e '/Name/s|Desktop   |Desktop|' \
		-e '/Icon/s|.png||' \
		-e '/Categories/s|Utiltity|Finance|' \
		-e '/Version/d' \
		-e "/Exec/s|=.*$|=env LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/opt/WebullDesktop /opt/WebullDesktop/WebullDesktop|" \
		usr/share/applications/WebullDesktop.desktop
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
		/opt/WebullDesktop/wbplugins/lib{accountbar,alert,componentsmanager,marketui,portfoliosui,stockstore}.so \
		/opt/WebullDesktop/wbplugins/lib{tradestore,usercentermanager,usercenterui,accountui,chartsui,marketstore}.so \
		/opt/WebullDesktop/wbplugins/lib{networkdetection,settingsui,stockui,tradeui,usercenterstore}.so \
		/opt/WebullDesktop/QtWebEngineProcess \
		/opt/WebullDesktop/WebullDesktop \
		/opt/WebullDesktop/chrome-sandbox \
		/opt/WebullDesktop/libicu{uc,data,i18n}.so.56 \
		/opt/WebullDesktop/libquazip1-qt5.1.4.so \
		/opt/WebullDesktop/libQt5{Concurrent,Core,DBus,Gui,Network,OpenGL,Positioning,PrintSupport,QmlModels}.so.5 \
		/opt/WebullDesktop/libQt5{Qml,Quick,QuickWidgets,SerialPort,Sql,Svg,WebChannel,WebEngineCore}.so.5 \
		/opt/WebullDesktop/libQt5{WebEngineWidgets,Widgets,X11Extras,XcbQpa,Xml}.so.5 \
		/opt/WebullDesktop/libQtAV.so{,.1,.1.13,.1.13.0} \
		/opt/WebullDesktop/libQtAVWidgets.so{,.1,.1.13,.1.13.0} \
		/opt/WebullDesktop/libsentry.so \
		/opt/WebullDesktop/libwb{basecore,basestore,baseui,charts,commonui,grpc,httpsclient,mqtt,storecommon}.so \
		/opt/WebullDesktop/libwb{uiframeworkmanager,updater,webviewui}.so

	patchelf --set-rpath "\$ORIGIN" "${ED}"/opt/WebullDesktop/libQtAV.so.1{,.13,.13.0} \
		"${ED}"/opt/WebullDesktop/libQtAVWidgets.so.1{,.13,.13.0} \
		|| die "patchelf failed"

	dosym ../WebullDesktop/WebullDesktop opt/bin/WebullDesktop
	dobin "${FILESDIR}"/webulldesktop
	pax-mark -m "${ED}"/opt/WebullDesktop/WebullDesktop
}

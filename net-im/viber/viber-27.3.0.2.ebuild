# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi fr
	gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru
	sk sl sr sv sw ta te th tr uk vi zh-CN zh-TW"
MULTILIB_COMPAT=( abi_x86_64 )

inherit chromium-2 desktop multilib-build pax-utils unpacker xdg

DESCRIPTION="Free text and calls"
HOMEPAGE="https://www.viber.com/en/"
SRC_URI="https://download.cdn.viber.com/cdn/desktop/Linux/${PN}.deb -> ${P}.deb"
S="${WORKDIR}"

LICENSE="viber"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="+abi_x86_64 apulse +pulseaudio"
REQUIRED_USE="^^ ( apulse pulseaudio )"
RESTRICT="bindist mirror splitdebug"

RDEPEND="app-arch/brotli:=[${MULTILIB_USEDEP}]
	app-arch/snappy:=[${MULTILIB_USEDEP}]
	app-arch/zstd:=[${MULTILIB_USEDEP}]
	app-crypt/libb2[${MULTILIB_USEDEP}]
	app-crypt/mit-krb5[${MULTILIB_USEDEP}]
	dev-libs/double-conversion
	dev-libs/expat[${MULTILIB_USEDEP}]
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/libevent:=[${MULTILIB_USEDEP}]
	dev-libs/libpcre2:=[${MULTILIB_USEDEP}]
	dev-libs/libxml2-compat:2[${MULTILIB_USEDEP}]
	dev-libs/libxslt[${MULTILIB_USEDEP}]
	dev-libs/nspr[${MULTILIB_USEDEP}]
	dev-libs/nss[${MULTILIB_USEDEP}]
	dev-libs/wayland[${MULTILIB_USEDEP}]
	media-libs/alsa-lib[${MULTILIB_USEDEP}]
	media-libs/fontconfig:1.0[${MULTILIB_USEDEP}]
	media-libs/freetype:2[${MULTILIB_USEDEP}]
	media-libs/gst-plugins-bad:1.0[${MULTILIB_USEDEP}]
	media-libs/gst-plugins-base:1.0[${MULTILIB_USEDEP}]
	media-libs/gstreamer:1.0[${MULTILIB_USEDEP}]
	media-libs/harfbuzz:=[${MULTILIB_USEDEP}]
	media-libs/lcms:2[${MULTILIB_USEDEP}]
	media-libs/libglvnd[${MULTILIB_USEDEP}]
	media-libs/libmng:=[${MULTILIB_USEDEP}]
	media-libs/libopenmpt[${MULTILIB_USEDEP}]
	media-libs/libpng:=[${MULTILIB_USEDEP}]
	media-libs/libtheora-compat:=[${MULTILIB_USEDEP}]
	media-libs/libwebp:=[${MULTILIB_USEDEP}]
	media-libs/opus[${MULTILIB_USEDEP}]
	media-libs/tiff-compat:4[${MULTILIB_USEDEP}]
	media-libs/xvid[${MULTILIB_USEDEP}]
	media-sound/wavpack[${MULTILIB_USEDEP}]
	net-print/cups[${MULTILIB_USEDEP}]
	sys-apps/dbus[${MULTILIB_USEDEP}]
	sys-libs/mtdev
	sys-process/numactl[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:3[${MULTILIB_USEDEP}]
	x11-libs/libdrm[${MULTILIB_USEDEP}]
	x11-libs/libICE[${MULTILIB_USEDEP}]
	x11-libs/libSM[${MULTILIB_USEDEP}]
	x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libxcb:=[${MULTILIB_USEDEP}]
	x11-libs/libXcomposite[${MULTILIB_USEDEP}]
	x11-libs/libXdamage[${MULTILIB_USEDEP}]
	x11-libs/libXext[${MULTILIB_USEDEP}]
	x11-libs/libXfixes[${MULTILIB_USEDEP}]
	x11-libs/libxkbcommon[${MULTILIB_USEDEP}]
	x11-libs/libxkbfile[${MULTILIB_USEDEP}]
	x11-libs/libXrandr[${MULTILIB_USEDEP}]
	x11-libs/libXScrnSaver[${MULTILIB_USEDEP}]
	x11-libs/libxshmfence[${MULTILIB_USEDEP}]
	x11-libs/libXtst[${MULTILIB_USEDEP}]
	x11-libs/pango[${MULTILIB_USEDEP}]
	x11-libs/tslib[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-cursor[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-image[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-keysyms[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-renderutil[${MULTILIB_USEDEP}]
	x11-libs/xcb-util-wm[${MULTILIB_USEDEP}]
	virtual/zlib:=[${MULTILIB_USEDEP}]
	apulse? ( media-sound/apulse[${MULTILIB_USEDEP}] )
	pulseaudio? (
		media-libs/libpulse[${MULTILIB_USEDEP}]
		media-plugins/gst-plugins-pulse[${MULTILIB_USEDEP}] )
	|| ( media-video/ffmpeg-compat:4[bluray,gsm,libsoxr,opencl,theora,twolame,vdpau,zvbi,${MULTILIB_USEDEP}]
		media-video/ffmpeg:0/56.58.58[bluray,gsm,libsoxr,opencl,theora,twolame,vdpau,zvbi,${MULTILIB_USEDEP}] )
	|| ( sys-apps/systemd[${MULTILIB_USEDEP}] sys-apps/systemd-utils[udev,${MULTILIB_USEDEP}] )"

QA_PREBUILT="opt/viber/Viber
	opt/viber/lib/libQt6WebEngineCore.so.6
	opt/viber/lib/libQt6QuickControls2BasicStyleImpl.so.6
	opt/viber/lib/libQt6QuickEffects.so.6
	opt/viber/lib/libQt6QmlMeta.so.6
	opt/viber/lib/libQt6EglFSDeviceIntegration.so.6
	opt/viber/lib/libQt6WebChannel.so.6
	opt/viber/lib/libQt6QuickDialogs2Utils.so.6
	opt/viber/lib/libQt6StateMachineQml.so.6
	opt/viber/lib/libQt6QuickControls2Basic.so.6
	opt/viber/lib/libdav1d.so.3
	opt/viber/lib/libnettle.so.6
	opt/viber/lib/libQt6LabsPlatform.so.6
	opt/viber/lib/libQt6DBus.so.6
	opt/viber/lib/libQt6Quick.so.6
	opt/viber/lib/libQt6QmlCore.so.6
	opt/viber/lib/libQt6QmlModels.so.6
	opt/viber/lib/libxcb-cursor.so.0
	opt/viber/lib/libQt6QuickControls2FusionStyleImpl.so.6
	opt/viber/lib/libQt6WaylandCompositorXdgShell.so.6
	opt/viber/lib/libQt6QuickControls2Impl.so.6
	opt/viber/lib/libQt6Widgets.so.6
	opt/viber/lib/libQt6QuickControls2FluentWinUI3StyleImpl.so.6
	opt/viber/lib/libQt6QuickDialogs2.so.6
	opt/viber/lib/libQt6WebSockets.so.6
	opt/viber/lib/libQt6LabsQmlModels.so.6
	opt/viber/lib/libQt6Core.so.6
	opt/viber/lib/libQt6QmlLocalStorage.so.6
	opt/viber/lib/libXcomposite.so.1
	opt/viber/lib/libQt6XcbQpa.so.6
	opt/viber/lib/libQt6QuickTemplates2.so.6
	opt/viber/lib/libQt6WlShellIntegration.so.6
	opt/viber/lib/libdouble-conversion.so.3
	opt/viber/lib/libQt6QuickControls2.so.6
	opt/viber/lib/libQt6OpenGL.so.6
	opt/viber/lib/libQt6StateMachine.so.6
	opt/viber/lib/libsrt.so.1
	opt/viber/lib/libQt6QuickDialogs2QuickImpl.so.6
	opt/viber/lib/libQt6WaylandCompositorPresentationTime.so.6
	opt/viber/lib/libtiff.so.5
	opt/viber/lib/libQt6Gui.so.6
	opt/viber/lib/libswscale.so.8
	opt/viber/lib/libQt6Concurrent.so.6
	opt/viber/lib/libthorvg.so.1
	opt/viber/lib/libQt6QuickShapesDesignHelpers.so.6
	opt/viber/lib/libQt6Multimedia.so.6
	opt/viber/lib/libwebpmux.so.3
	opt/viber/lib/libQt6Sql.so.6
	opt/viber/lib/libQt6QuickShapes.so.6
	opt/viber/lib/libQt6Qml.so.6
	opt/viber/lib/libQt6MultimediaQuick.so.6
	opt/viber/lib/libQt6QmlWorkerScript.so.6
	opt/viber/lib/libminizip.so.1
	opt/viber/lib/libavcodec.so.61
	opt/viber/lib/libpng16.so.16
	opt/viber/lib/libswresample.so.5
	opt/viber/lib/libQt6LabsFolderListModel.so.6
	opt/viber/lib/libQt6WebChannelQuick.so.6
	opt/viber/lib/libicui18n.so.60
	opt/viber/lib/libQt6WaylandCompositorWLShell.so.6
	opt/viber/lib/libQt6WebEngineQuick.so.6
	opt/viber/lib/libavutil.so.59
	opt/viber/lib/libQt6QmlXmlListModel.so.6
	opt/viber/lib/libQt6LabsAnimation.so.6
	opt/viber/lib/libwebpdemux.so.2
	opt/viber/lib/libb2.so.1
	opt/viber/lib/libQt6WebEngineQuickDelegatesQml.so.6
	opt/viber/lib/libQt6Network.so.6
	opt/viber/lib/libQt6WaylandCompositorIviapplication.so.6
	opt/viber/lib/libicuuc.so.60
	opt/viber/lib/libXdamage.so.1
	opt/viber/lib/libQt6WaylandClient.so.6
	opt/viber/lib/libavformat.so.61
	opt/viber/lib/libicudata.so.60
	opt/viber/lib/libQt6QuickLayouts.so.6
	opt/viber/lib/libwebp.so.7
	opt/viber/lib/libQt6QuickControls2Fusion.so.6
	opt/viber/lib/libQt6WaylandCompositor.so.6
	opt/viber/plugins/networkinformation/libqnetworkmanager.so
	opt/viber/plugins/networkinformation/libqglib.so
	opt/viber/plugins/imageformats/libqtiff.so
	opt/viber/plugins/imageformats/libqwebp.so
	opt/viber/plugins/imageformats/libqtga.so
	opt/viber/plugins/imageformats/libqwbmp.so
	opt/viber/plugins/imageformats/libqicns.so
	opt/viber/plugins/imageformats/libqgif.so
	opt/viber/plugins/imageformats/libqico.so
	opt/viber/plugins/imageformats/libqjpeg.so
	opt/viber/plugins/tls/libqopensslbackend.so
	opt/viber/plugins/tls/libqcertonlybackend.so
	opt/viber/plugins/platforminputcontexts/libcomposeplatforminputcontextplugin.so
	opt/viber/plugins/platforminputcontexts/libibusplatforminputcontextplugin.so
	opt/viber/plugins/wayland-graphics-integration-client/libvulkan-server.so
	opt/viber/plugins/wayland-graphics-integration-client/libshm-emulation-server.so
	opt/viber/plugins/wayland-graphics-integration-client/libdmabuf-server.so
	opt/viber/plugins/wayland-graphics-integration-client/libqt-plugin-wayland-egl.so
	opt/viber/plugins/wayland-graphics-integration-client/libdrm-egl-server.so
	opt/viber/plugins/multimedia/libffmpegmediaplugin.so
	opt/viber/plugins/xcbglintegrations/libqxcb-glx-integration.so
	opt/viber/plugins/xcbglintegrations/libqxcb-egl-integration.so
	opt/viber/plugins/wayland-decoration-client/libbradient.so
	opt/viber/plugins/sqldrivers/libqsqlite.so
	opt/viber/plugins/platforms/libqwayland.so
	opt/viber/plugins/platforms/libqxcb.so
	opt/viber/plugins/platforms/libqoffscreen.so
	opt/viber/plugins/platforms/libqminimal.so
	opt/viber/plugins/platforms/libqvkkhrdisplay.so
	opt/viber/plugins/platforms/libqvnc.so
	opt/viber/plugins/platforms/libqlinuxfb.so
	opt/viber/plugins/platforms/libqminimalegl.so
	opt/viber/plugins/platforms/libqeglfs.so
	opt/viber/plugins/platformthemes/libqgtk3.so
	opt/viber/plugins/platformthemes/libqxdgdesktopportal.so
	opt/viber/plugins/wayland-shell-integration/libqt-shell.so
	opt/viber/plugins/wayland-shell-integration/libfullscreen-shell-v1.so
	opt/viber/plugins/wayland-shell-integration/libwl-shell-plugin.so
	opt/viber/plugins/wayland-shell-integration/libivi-shell.so
	opt/viber/plugins/wayland-shell-integration/libxdg-shell.so
	opt/viber/qml/QtWayland/Client/TextureSharing/libwaylandtexturesharingplugin.so
	opt/viber/qml/QtWayland/Compositor/WlShell/libwaylandcompositorwlshellplugin.so
	opt/viber/qml/QtWayland/Compositor/libqwaylandcompositorplugin.so
	opt/viber/qml/QtWayland/Compositor/TextureSharingExtension/libwaylandtexturesharingextensionplugin.so
	opt/viber/qml/QtWayland/Compositor/XdgShell/libwaylandcompositorxdgshellplugin.so
	opt/viber/qml/QtWayland/Compositor/PresentationTime/libwaylandcompositorpresentationtimeplugin.so
	opt/viber/qml/QtWayland/Compositor/IviApplication/libwaylandcompositoriviapplicationplugin.so
	opt/viber/qml/QtWayland/Compositor/QtShell/libwaylandcompositorqtshellplugin.so
	opt/viber/qml/QtWebEngine/ControlsDelegates/libqtwebenginequickdelegatesplugin.so
	opt/viber/qml/QtWebEngine/libqtwebenginequickplugin.so
	opt/viber/qml/QtMultimedia/libquickmultimediaplugin.so
	opt/viber/qml/QtCore/libqtqmlcoreplugin.so
	opt/viber/qml/QtQuick/Window/libquickwindowplugin.so
	opt/viber/qml/QtQuick/Effects/libeffectsplugin.so
	opt/viber/qml/QtQuick/Shapes/libqmlshapesplugin.so
	opt/viber/qml/QtQuick/Shapes/DesignHelpers/libqtquickshapesdesignhelpersplugin.so
	opt/viber/qml/QtQuick/LocalStorage/libqmllocalstorageplugin.so
	opt/viber/qml/QtQuick/Templates/libqtquicktemplates2plugin.so
	opt/viber/qml/QtQuick/Layouts/libqquicklayoutsplugin.so
	opt/viber/qml/QtQuick/Dialogs/quickimpl/libqtquickdialogs2quickimplplugin.so
	opt/viber/qml/QtQuick/Dialogs/libqtquickdialogsplugin.so
	opt/viber/qml/QtQuick/tooling/libquicktoolingplugin.so
	opt/viber/qml/QtQuick/Controls/libqtquickcontrols2plugin.so
	opt/viber/qml/QtQuick/Controls/Fusion/libqtquickcontrols2fusionstyleplugin.so
	opt/viber/qml/QtQuick/Controls/Fusion/impl/libqtquickcontrols2fusionstyleimplplugin.so
	opt/viber/qml/QtQuick/Controls/FluentWinUI3/libqtquickcontrols2fluentwinui3styleplugin.so
	opt/viber/qml/QtQuick/Controls/FluentWinUI3/impl/libqtquickcontrols2fluentwinui3styleimplplugin.so
	opt/viber/qml/QtQuick/Controls/Basic/libqtquickcontrols2basicstyleplugin.so
	opt/viber/qml/QtQuick/Controls/Basic/impl/libqtquickcontrols2basicstyleimplplugin.so
	opt/viber/qml/QtQuick/Controls/impl/libqtquickcontrols2implplugin.so
	opt/viber/qml/QtQuick/libqtquick2plugin.so
	opt/viber/qml/QtQml/libqmlplugin.so
	opt/viber/qml/QtQml/Models/libmodelsplugin.so
	opt/viber/qml/QtQml/XmlListModel/libqmlxmllistmodelplugin.so
	opt/viber/qml/QtQml/WorkerScript/libworkerscriptplugin.so
	opt/viber/qml/QtQml/StateMachine/libqtqmlstatemachineplugin.so
	opt/viber/qml/QtWebChannel/libwebchannelquickplugin.so
	opt/viber/qml/Qt/labs/qmlmodels/liblabsmodelsplugin.so
	opt/viber/qml/Qt/labs/animation/liblabsanimationplugin.so
	opt/viber/qml/Qt/labs/platform/liblabsplatformplugin.so
	opt/viber/qml/Qt/labs/folderlistmodel/libqmlfolderlistmodelplugin.so
	opt/viber/libexec/QtWebEngineProcess"

src_prepare() {
	default
	pushd opt/viber/translations/qtwebengine_locales || die "pushd failed"
	chromium_remove_language_paks
	popd || die "popd failed"

	if use apulse ; then
		sed -i '/Exec=/s|/opt|apulse /opt|' \
			usr/share/applications/viber.desktop || die "sed failed"
	fi

	# remove hardcoded path
	sed -i '/Icon/s|/usr/share/pixmaps/viber.png|viber|' \
		usr/share/applications/viber.desktop \
		|| die "sed failed for viber.desktop"
}

src_install() {
	newicon -s scalable usr/share/icons/hicolor/scalable/apps/Viber.svg \
		viber.svg
	for size in 16 24 32 48 64 96 128 256 ; do
		newicon -s "${size}" usr/share/viber/"${size}x${size}".png viber.png
	done
	dosym ../icons/hicolor/256x256/apps/viber.png \
		/usr/share/pixmaps/viber.png

	domenu usr/share/applications/viber.desktop

	insinto /opt/viber
	doins -r opt/viber/.

	pax-mark -m "${ED}"/opt/viber/Viber "${ED}"/opt/viber/QtWebEngineProcess

	fperms +x /opt/viber/Viber /opt/viber/libexec/QtWebEngineProcess
	dosym ../../opt/viber/Viber /usr/bin/Viber
}

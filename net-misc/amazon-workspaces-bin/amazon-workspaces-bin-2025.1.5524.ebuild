# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLOCALES="de en id pt tr zh"
PLOCALE_BACKUP="en"

inherit edo gnome2-utils pax-utils plocale unpacker xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Amazon Workspace Client"
HOMEPAGE="https://clients.amazonworkspaces.com"
SRC_URI="https://d3nt0h4h6pmmc4.cloudfront.net/new_workspacesclient_jammy_amd64.deb
	-> workspacesclient-${PV}_amd64.deb"
S="${WORKDIR}"

LICENSE="all-rights-reserved Apache-2.0 GPL-2 MIT no-source-code"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

RDEPEND="app-accessibility/at-spi2-core:2
	app-arch/brotli:0=
	app-arch/bzip2:0=
	app-text/enchant:2
	dev-db/sqlite:3
	dev-lang/orc
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/fribidi
	dev-libs/hyphen
	dev-libs/icu:0/77=
	dev-libs/libffi:0=
	dev-libs/libtasn1:0=
	dev-libs/libgcrypt:0/20
	dev-libs/libgpg-error
	dev-libs/libpcre2:0=
	dev-libs/libunistring:0=
	dev-libs/libxml2:2
	dev-libs/libxslt
	dev-libs/wayland
	media-gfx/graphite2
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/harfbuzz:0=
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/gstreamer:1.0[unwind]
	>=media-libs/jbigkit-2.1-r1:0=
	media-libs/lcms:2
	media-libs/libepoxy
	media-libs/libglvnd
	media-libs/libjpeg-turbo:0=
	media-libs/libpng:0=
	media-libs/libva:0=
	media-libs/libwebp:0=
	media-libs/mesa
	media-libs/openjpeg:2
	media-libs/tiff:0=[jbig]
	media-libs/woff2
	net-dns/libidn2:0=
	net-libs/libpsl
	net-libs/libsoup:2.4
	net-libs/webkit-gtk:4.1
	sys-apps/dbus
	sys-apps/util-linux
	sys-libs/libseccomp
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libxcb:0=
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/pango
	x11-libs/pixman
	x11-libs/libvdpau
	virtual/krb5
	virtual/zlib:0="
BDEPEND="dev-util/patchelf"

QA_PREBUILT="usr/share/workspacesclient/cef/libEGL.so
	usr/share/workspacesclient/cef/libcef.so
	usr/share/workspacesclient/cef/libvk_swiftshader.so
	usr/share/workspacesclient/cef/chrome-sandbox
	usr/share/workspacesclient/cef/libGLESv2.so
	usr/share/workspacesclient/cef/libvulkan.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/libepoxy.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libsoup-3.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libdav1d.so.7
	usr/lib/x86_64-linux-gnu/workspacesclient/liblmdb.so
	usr/lib/x86_64-linux-gnu/workspacesclient/libgstallocators-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/librsvg-2.so.2
	usr/lib/x86_64-linux-gnu/workspacesclient/libopus.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libglib-2.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libwayland-egl.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/libharfbuzz.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libgmodule-2.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libjson-glib-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libvpx.so.11
	usr/lib/x86_64-linux-gnu/workspacesclient/sasl2/libotp.so
	usr/lib/x86_64-linux-gnu/workspacesclient/sasl2/libgs2.so
	usr/lib/x86_64-linux-gnu/workspacesclient/sasl2/libgssapiv2.so
	usr/lib/x86_64-linux-gnu/workspacesclient/sasl2/libscram.so
	usr/lib/x86_64-linux-gnu/workspacesclient/sasl2/libsasldb.so
	usr/lib/x86_64-linux-gnu/workspacesclient/sasl2/libanonymous.so
	usr/lib/x86_64-linux-gnu/workspacesclient/sasl2/libplain.so
	usr/lib/x86_64-linux-gnu/workspacesclient/sasl2/libdigestmd5.so
	usr/lib/x86_64-linux-gnu/workspacesclient/sasl2/libcrammd5.so
	usr/lib/x86_64-linux-gnu/workspacesclient/libgstbadaudio-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libpcre2-8.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/gio/modules/libgioopenssl.so
	usr/lib/x86_64-linux-gnu/workspacesclient/gio/modules/libgiolibproxy.so
	usr/lib/x86_64-linux-gnu/workspacesclient/libjpeg.so.62
	usr/lib/x86_64-linux-gnu/workspacesclient/gst-plugin-scanner
	usr/lib/x86_64-linux-gnu/workspacesclient/gstreamer-1.0/libgstcutter.so
	usr/lib/x86_64-linux-gnu/workspacesclient/gstreamer-1.0/libgstvideo4linux2.so
	usr/lib/x86_64-linux-gnu/workspacesclient/gstreamer-1.0/libgstpulseaudio.so
	usr/lib/x86_64-linux-gnu/workspacesclient/gstreamer-1.0/libgstvpx.so
	usr/lib/x86_64-linux-gnu/workspacesclient/gstreamer-1.0/libgstopus.so
	usr/lib/x86_64-linux-gnu/workspacesclient/gstreamer-1.0/libgstcoreelements.so
	usr/lib/x86_64-linux-gnu/workspacesclient/gstreamer-1.0/libgstvideorate.so
	usr/lib/x86_64-linux-gnu/workspacesclient/gstreamer-1.0/libgstaudioconvert.so
	usr/lib/x86_64-linux-gnu/workspacesclient/gstreamer-1.0/libgstvideoconvertscale.so
	usr/lib/x86_64-linux-gnu/workspacesclient/gstreamer-1.0/libgstaudioresample.so
	usr/lib/x86_64-linux-gnu/workspacesclient/gstreamer-1.0/libgstapp.so
	usr/lib/x86_64-linux-gnu/workspacesclient/gstreamer-1.0/libgstwebrtcdsp.so
	usr/lib/x86_64-linux-gnu/workspacesclient/libgobject-2.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libpangoft2-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libffi.so.8
	usr/lib/x86_64-linux-gnu/workspacesclient/libtiff.so.6
	usr/lib/x86_64-linux-gnu/workspacesclient/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-gif.so
	usr/lib/x86_64-linux-gnu/workspacesclient/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-jpeg.so
	usr/lib/x86_64-linux-gnu/workspacesclient/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-svg.so
	usr/lib/x86_64-linux-gnu/workspacesclient/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-png.so
	usr/lib/x86_64-linux-gnu/workspacesclient/gtk4-update-icon-cache
	usr/lib/x86_64-linux-gnu/workspacesclient/libgio-2.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libcairo.so.2
	usr/lib/x86_64-linux-gnu/workspacesclient/libpixman-1.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libpsl.so.5
	usr/lib/x86_64-linux-gnu/workspacesclient/libdcv.so
	usr/lib/x86_64-linux-gnu/workspacesclient/libprotobuf-c.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/libcairo-gobject.so.2
	usr/lib/x86_64-linux-gnu/workspacesclient/libfontconfig.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/libpango-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libpangoxft-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libproxy.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/libfreetype.so.6
	usr/lib/x86_64-linux-gnu/workspacesclient/libgstvideo-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libz.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/libwayland-client.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libcairo-script-interpreter.so.2
	usr/lib/x86_64-linux-gnu/workspacesclient/libturbojpeg.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libgstbase-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libgtk-4.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/libharfbuzz-icu.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/glib-compile-resources
	usr/lib/x86_64-linux-gnu/workspacesclient/libexpat.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/libpangocairo-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libfribidi.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libfido2.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/gtk-4.0/4.0.0/printbackends/libprintbackend-file.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcvextensionswatchdog
	usr/lib/x86_64-linux-gnu/workspacesclient/libavcodec.so.61
	usr/lib/x86_64-linux-gnu/workspacesclient/libgthread-2.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libavutil.so.59
	usr/lib/x86_64-linux-gnu/workspacesclient/liborc-0.4.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libgstreamer-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libnghttp2.so.14
	usr/lib/x86_64-linux-gnu/workspacesclient/libharfbuzz-subset.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libgstapp-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libpxbackend-1.0.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcvwebrtcredirextension
	usr/lib/x86_64-linux-gnu/workspacesclient/libgstaudio-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libgdk_pixbuf-2.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/gdk-pixbuf-query-loaders
	usr/lib/x86_64-linux-gnu/workspacesclient/dcvviewer
	usr/lib/x86_64-linux-gnu/workspacesclient/liblz4.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/libwayland-cursor.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libgraphene-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/libsasl2.so.3
	usr/lib/x86_64-linux-gnu/workspacesclient/libwebrtc-audio-processing-2.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/glib-compile-schemas
	usr/bin/workspacesclient"

src_prepare() {
	default

	my_rm_loc() {
		rm -rf usr/share/locale/"${1}" || die "rm failed for ${1}"
	}
	plocale_for_each_disabled_locale my_rm_loc

	edo rm -rf usr/share/doc
	edo patchelf --replace-needed libicuuc.so.70 libicuuc.so.77 \
		usr/lib/x86_64-linux-gnu/workspacesclient/libharfbuzz-icu.so.0
	# x11-libs/pango disables libthai
	edo patchelf --remove-needed libthai.so.0 usr/lib/x86_64-linux-gnu/workspacesclient/libpango-1.0.so.0
}

src_install() {
	insinto /
	doins -r .
	fperms +x /usr/bin/workspacesclient \
		/usr/lib/x86_64-linux-gnu/workspacesclient/dcv{extensionswatchdog,viewer,webrtcredirextension} \
		/usr/lib/x86_64-linux-gnu/workspacesclient/gdk-pixbuf-query-loaders \
		/usr/lib/x86_64-linux-gnu/workspacesclient/glib-compile-{resources,schemas} \
		/usr/lib/x86_64-linux-gnu/workspacesclient/gst-plugin-scanner \
		/usr/lib/x86_64-linux-gnu/workspacesclient/gtk4-update-icon-cache \
		/usr/lib/x86_64-linux-gnu/workspacesclient/workspacesclientdcv

	dosym ../lib/x86_64-linux-gnu/workspacesclient/workspacesclientdcv \
		/usr/bin/workspacesclientdcv

	pax-mark -m "${ED}"/usr/bin/workspacesclient "${ED}"/usr/bin/workspacesclientdcv

}

pkg_preinst() {
	gnome2_gdk_pixbuf_savelist
	xdg_pkg_preinst
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}

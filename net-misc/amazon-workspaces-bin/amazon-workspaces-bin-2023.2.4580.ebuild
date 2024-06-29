# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils pax-utils unpacker xdg

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
	dev-libs/icu:0=
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
	net-libs/webkit-gtk:4
	sys-apps/dbus
	sys-apps/util-linux
	sys-libs/libseccomp
	sys-libs/zlib:0=
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
	virtual/krb5"
BDEPEND="dev-util/patchelf"

QA_PREBUILT="usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libepoxy.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libgtk-3.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libsoup-3.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/liblmdb.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libgstallocators-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/librsvg-2.so.2
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libopus.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libglib-2.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libwayland-egl.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libharfbuzz.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libgmodule-2.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libjson-glib-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libvpx.so.8
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libgailutil-3.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/dcvclientbin
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gtk-3.0/3.0.0/immodules/im-viqr.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gtk-3.0/3.0.0/immodules/im-ipa.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gtk-3.0/3.0.0/immodules/im-ti-et.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gtk-3.0/3.0.0/immodules/im-cyrillic-translit.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gtk-3.0/3.0.0/immodules/im-wayland.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gtk-3.0/3.0.0/immodules/im-cedilla.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gtk-3.0/3.0.0/immodules/im-am-et.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gtk-3.0/3.0.0/immodules/im-multipress.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gtk-3.0/3.0.0/immodules/im-thai.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gtk-3.0/3.0.0/immodules/im-xim.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gtk-3.0/3.0.0/immodules/im-inuktitut.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gtk-3.0/3.0.0/immodules/im-ti-er.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/sasl2/libotp.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/sasl2/libgs2.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/sasl2/libgssapiv2.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/sasl2/libscram.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/sasl2/libsasldb.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/sasl2/libanonymous.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/sasl2/libplain.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/sasl2/libdigestmd5.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/sasl2/libcrammd5.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libpcre2-8.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gio/modules/libgioopenssl.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libjpeg.so.62
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gst-plugin-scanner
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gstreamer-1.0/libgstcutter.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gstreamer-1.0/libgstvideo4linux2.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gstreamer-1.0/libgstpulseaudio.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gstreamer-1.0/libgstvpx.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gstreamer-1.0/libgstopus.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gstreamer-1.0/libgstcoreelements.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gstreamer-1.0/libgstvideorate.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gstreamer-1.0/libgstaudioconvert.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gstreamer-1.0/libgstvideoconvertscale.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gstreamer-1.0/libgstaudioresample.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gstreamer-1.0/libgstapp.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libgobject-2.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libpangoft2-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libdcvwebauthnredirection.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libffi.so.8
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libtiff.so.6
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-bmp.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-gif.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-ani.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-xbm.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-pnm.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-jpeg.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-tga.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-qtif.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-svg.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-png.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-xpm.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-icns.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-ico.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libgio-2.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libcairo.so.2
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libpixman-1.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libpsl.so.5
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libdcv.so
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libprotobuf-c.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libcairo-gobject.so.2
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libfontconfig.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libpango-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libpangoxft-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libfreetype.so.6
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libgstvideo-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libz.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libwayland-client.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libcairo-script-interpreter.so.2
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libturbojpeg.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libavutil.so.58
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libgstbase-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libharfbuzz-icu.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libexpat.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libpangocairo-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libfribidi.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libatk-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libgthread-2.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/liborc-0.4.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libgstreamer-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gtk-query-immodules-3.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libnghttp2.so.14
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libgdk-3.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libharfbuzz-subset.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libgstapp-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libgstaudio-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libgdk_pixbuf-2.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libavcodec.so.60
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gdk-pixbuf-query-loaders
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/liblz4.so.1
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libwayland-cursor.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libgraphene-1.0.so.0
	usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libsasl2.so.3
	usr/bin/workspacesclient"

src_prepare() {
	default

	rm -rf usr/share/doc || die "remove license"
	patchelf --replace-needed libicuuc.so.70 libicuuc.so.73 \
		usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libharfbuzz-icu.so.0 \
		|| die "patchelf failed for libicuuc.so"
	# x11-libs/pango disables libthai
	patchelf --remove-needed libthai.so.0 usr/lib/x86_64-linux-gnu/workspacesclient/dcv/libpango-1.0.so.0 \
		|| die "patchelf remove failed for libthai.so.0"
}

src_install() {
	insinto /
	doins -r .
	fperms +x /usr/bin/workspacesclient \
		/usr/lib/x86_64-linux-gnu/workspacesclient/dcv/dcvclient{,bin} \
		/usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gdk-pixbuf-query-loaders \
		/usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gst-plugin-scanner \
		/usr/lib/x86_64-linux-gnu/workspacesclient/dcv/gtk-query-immodules-3.0

	dosym ../lib/x86_64-linux-gnu/workspacesclient/dcv/dcvclient \
		/usr/bin/dcvclient
	dosym ../lib/x86_64-linux-gnu/workspacesclient/dcv/dcvclientbin \
		/usr/bin/dcvclientbin

	pax-mark -m "${ED}"/usr/bin/workspacesclient
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

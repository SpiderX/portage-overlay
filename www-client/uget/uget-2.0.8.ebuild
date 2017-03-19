# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2-utils

LANGUAGES="linguas_ar linguas_be linguas_bg linguas_bn_BD linguas_ca linguas_cs
	linguas_da linguas_de linguas_es linguas_fa linguas_fr linguas_he
	linguas_hr linguas_hu linguas_id linguas_it linguas_ka_GE linguas_kk
	linguas_ku linguas_pl linguas_pt_BR linguas_ru
	linguas_sk_SK linguas_sr linguas_sr@latin linguas_sv linguas_tr
	linguas_uk linguas_uz@Latn linguas_vi linguas_zh_CN linguas_zh_TW"

DESCRIPTION="Download manager using gtk+ and libcurl"
HOMEPAGE="http://www.ugetdm.com"
SRC_URI="mirror://sourceforge/urlget/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="appindicator gnutls gstreamer libnotify nls ssl rss socket ssl ${LANGUAGES}"

REQUIRED_USE="^^ ( ssl gnutls )"

RDEPEND="dev-libs/glib:2
	net-misc/curl
	x11-libs/gtk+:3
	gnutls? (
		dev-libs/libgcrypt:0
		net-libs/gnutls
		)
	gstreamer? ( media-libs/gstreamer:1.0 )
	libnotify? ( x11-libs/libnotify )
	ssl? ( dev-libs/openssl:0 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf

	# Patch needs to be applied after eautoreconf, do not use PATCHES
	eapply "${FILESDIR}"/${P}-linguas-fix.patch
}

src_configure() {
	#TODO: --enable-pwm pwm Enable pwm <pkg>app-admin/pwmd</pkg> support
	econf --disable-pwmd \
		$(use_enable appindicator) \
		$(use_enable gstreamer) \
		$(use_enable libnotify notify) \
		$(use_enable nls) \
		$(use_enable rss rss-notify) \
		$(use_enable socket unix-socket) \
		$(use_with ssl openssl) \
		$(use_with gnutls)
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

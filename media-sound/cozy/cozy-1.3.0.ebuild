# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2317

EAPI=8

PLOCALES="be_BY bg cs da de el eo es fa_IR fi fr gl he hi hr hu it ms_MY nl no oc pl pt_BR pt ru sv tr uk zh"
PLOCALE_BACKUP="en"
PYTHON_COMPAT=( python3_{10..13} )
PYTHON_REQ_USE="sqlite"

inherit gnome2-utils meson plocale python-single-r1 xdg

DESCRIPTION="Modern audiobook player"
HOMEPAGE="https://github.com/geigi/cozy"
SRC_URI="https://github.com/geigi/cozy/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="appstream"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-libs/glib:2
	gui-libs/gtk:4[introspection]
	gui-libs/libadwaita:1[introspection]
	dev-python/distro
	dev-python/peewee
	dev-python/pygobject:3
	dev-python/pytz
	dev-python/requests
	media-libs/gstreamer:1.0=[introspection]
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-base:1.0[introspection]
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-ugly:1.0
	media-plugins/gst-plugins-libav:1.0
	media-libs/mutagen
	x11-libs/gtk+:3[introspection]
	appstream? ( dev-libs/appstream:0= )"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig"

src_prepare() {
	default

	my_rm_loc() {
		rm po/"${1}".po || die "rm failed for po/${1}.po"
		sed -i "/${1}/d" po/LINGUAS || die "sed failed for po/LINGUAS"
		if [ -f po/extra/"${1}".po ] ; then
			rm po/extra/"${1}".po || die "rm failed for extra/${1}.po"
			sed -i "/${1}/d" po/extra/LINGUAS || die "sed failed for po/extra/LINGUAS"
		fi
	}
	plocale_for_each_disabled_locale my_rm_loc
}

src_install() {
	meson_src_install
	python_optimize
	python_fix_shebang "${ED}"/usr/bin
	dosym ./com.github.geigi.cozy /usr/bin/cozy
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}

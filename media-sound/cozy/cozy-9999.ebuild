# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/geigi/${PN}.git"
PYTHON_COMPAT=( python3_{9..12} )

inherit git-r3 gnome2-utils meson python-single-r1 readme.gentoo-r1 xdg

DESCRIPTION="Modern audiobook player"
HOMEPAGE="https://github.com/geigi/cozy"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="appstream"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-libs/glib:2
	dev-libs/libdazzle[introspection]
	dev-python/distro
	dev-python/packaging
	dev-python/peewee
	dev-python/pygobject:3
	dev-python/pytz
	dev-python/requests
	gui-libs/libhandy:1[introspection]
	media-libs/gstreamer:1.0=[introspection]
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-base:1.0[introspection]
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-ugly:1.0
	media-plugins/gst-plugins-libav:1.0
	media-libs/mutagen
	x11-libs/gtk+:3[introspection]
	appstream? ( dev-libs/appstream:0= )"
BDEPEND="sys-devel/gettext"

# https://github.com/geigi/cozy/issues/756
DOC_CONTENTS="The following must be executed after install:\\n
gsettings set com.github.geigi.cozy last-launched-version '1.2.1'"

src_prepare() {
	default

	sed -i '/post_install_desktop_database.py/d' meson.build \
		|| die "sed failed"
}

src_install() {
	meson_src_install
	readme.gentoo_create_doc
	python_optimize
	dosym ./com.github.geigi.cozy /usr/bin/cozy
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_schemas_savelist
}

pkg_postinst() {
	readme.gentoo_print_elog
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}

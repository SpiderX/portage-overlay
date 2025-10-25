# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLOCALES="ar bg bqi ca cs da de el eo es et eu fa fil fi fr_FR ga gl he hi hr hu ia id it ja ko nb_NO ne nl oc pl pt_BR pt ro ru si sk sr@latin sr sv ta tr uk zh_Hans zh_Hant"

inherit cargo gnome2-utils meson plocale xdg

DESCRIPTION="GTK4 screen recorder for Wayland"
HOMEPAGE="https://github.com/SeaDve/Kooha"
SRC_URI="https://github.com/SeaDve/${PN^}/releases/download/v${PV}/kooha-${PV}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="x264 vaapi test"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/glib:2
	gui-libs/gtk:4
	gui-libs/libadwaita:1
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/graphene
	media-libs/libpulse[glib]
	media-video/pipewire:=[gstreamer]
	sys-apps/xdg-desktop-portal
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
	vaapi? ( media-plugins/gst-plugins-vaapi:1.0 )
	x264? ( media-libs/x264:0=
		media-libs/gst-plugins-ugly:1.0 )"
RDEPEND="${DEPEND}"
BDEPEND="app-alternatives/ninja
	dev-build/meson
	dev-libs/appstream-glib:=
	test? ( || ( dev-lang/rust[clippy] dev-lang/rust-bin[clippy] ) )"

QA_FLAGS_IGNORED="usr/bin/kooha"

BUILD_DIR="${S}/build"

src_prepare() {
	default

	my_rm_loc() {
		rm po/"${1}".po || die "rm failed for ${1}.po"
		sed -i "/${1}/d" po/LINGUAS || die "sed failed for po/LINGUAS"
	}
	plocale_for_each_disabled_locale my_rm_loc

	# don't update icon cache within meson
	sed -i '/^gnome.post_install/,+4d' meson.build || die "sed failed for meson.build"
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}

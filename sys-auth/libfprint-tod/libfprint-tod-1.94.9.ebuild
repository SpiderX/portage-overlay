# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson udev

MY_PN="${PN/-tod/}"

DESCRIPTION="libfprint for Touch OEM Drivers"
HOMEPAGE="https://gitlab.freedesktop.org/3v1n0/libfprint/-/tree/tod/"
SRC_URI="https://gitlab.freedesktop.org/3v1n0/${MY_PN}/-/archive/v${PV}+tod1/${MY_PN}-v${PV}+tod1.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${MY_PN}-v${PV}+tod1"

LICENSE="LGPL-2.1+"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="examples gtk-doc introspection"

RDEPEND="!sys-auth/libfprint:2
	dev-libs/glib:2
	dev-libs/libgudev:=
	dev-libs/libgusb
	dev-libs/nss
	dev-python/pygobject:3
	x11-libs/pixman
	examples? ( x11-libs/gdk-pixbuf:2
		x11-libs/gtk+:3 )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	gtk-doc? ( dev-util/gtk-doc )
	introspection? ( dev-libs/gobject-introspection
		dev-libs/libgusb[introspection] )"

src_configure() {
	# TODO: wire up test deps (cairo, pygobject, etc) for extra tests
	# currently skipped.
	local emesonargs=(
		"$(meson_use examples gtk-examples)"
		"$(meson_use gtk-doc doc)"
		"$(meson_use introspection introspection)"
		-Ddrivers=all
		-Dinstalled-tests=false
		-Dudev_rules=enabled
		-Dudev_rules_dir="$(get_udevdir)"/rules.d
	)
	meson_src_configure
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}

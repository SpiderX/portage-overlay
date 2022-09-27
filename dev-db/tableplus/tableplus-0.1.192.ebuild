# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop pax-utils unpacker

DESCRIPTION="Modern, native, and friendly GUI tool for relational databases"
HOMEPAGE="https://tableplus.com"
SRC_URI="https://deb.tableplus.com/debian/pool/main/t/${PN}/${PN}_${PV}_amd64.deb"

LICENSE="TablePlus"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

RDEPEND="app-crypt/libsecret:0
	app-crypt/mit-krb5:0
	dev-libs/glib:2
	dev-libs/json-glib:0
	dev-libs/libgee:0.8
	net-nds/openldap:0
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/gtksourceview:3.0
	x11-libs/pango:0"

S="${WORKDIR}"

src_prepare() {
	default

	# Remove hardcoded path
	sed -i  -e '/Icon/s|/opt/tableplus/resource/image/logo.png|tableplus|' \
		-e '/Exec/s|local/||' opt/tableplus/tableplus.desktop \
		|| die "sed failed for tebleplus.desktop"
}

src_install() {
	dobin opt/tableplus/tableplus
	pax-mark m "${ED}"/usr/bin/tableplus

	newicon opt/tableplus/resource/image/logo.png tableplus.png
	newicon -s 512 opt/tableplus/resource/image/logo.png tableplus.png
	domenu opt/tableplus/tableplus.desktop
}

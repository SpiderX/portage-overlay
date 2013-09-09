# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="Effectively suppresses illegal DHCP servers on the LAN"
HOMEPAGE="http://www.netpatch.ru/dhcdrop.html"
SRC_URI="http://www.netpatch.ru/projects/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="static"
RDEPEND="net-libs/libpcap
	static? ( net-libs/libpcap[static-libs] )"
DOCS="AUTHORS ChangeLog INSTALL NEWS README"

src_prepare() {
	# Fix static-build handling
	epatch "${FILESDIR}"/dhcdrop-0.5-configure.patch
}

src_configure() {
	econf $(use_enable static static-build)
}

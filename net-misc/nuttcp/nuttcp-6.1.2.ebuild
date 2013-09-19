# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="Network performance measurement tool"
HOMEPAGE="http://www.nuttcp.net/"
SRC_URI="http://lcp.nrl.navy.mil/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="examples ipv6 xinetd"

RDEPEND="xinetd? ( sys-apps/xinetd )"

src_prepare() {
	# Remove hardcoded flags and make use of system ones
	epatch "${FILESDIR}"/nuttcp-6.1.2-makefile.patch

	epatch_user
}

src_compile() {
	emake $(usex ipv6 '' NOIPV6=-DNO_IPV6)
}

src_install() {
	# Install nuttcp binary
	if use ipv6 ; then
		newbin "${S}"/${P} ${PN}
	else
		newbin "${S}"/${P}-noipv6 ${PN}
	fi

	# Install Gentoo init script and its config
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}

	# Install manual page and documentation
	doman "${S}"/${PN}.8
	dodoc "${S}"/README

	if use examples ; then
		insinto /usr/share/${P}
		doins "${S}"/examples.txt
	fi

	if use xinetd ; then
		insinto /etc/xinetd.d
		doins "${S}"/xinetd.d/${PN}
	fi
}

pkg_postinst() {
	elog "You may need to add these lines to /etc/services:"
	elog
	elog "nuttcp          5000/tcp"
	elog "nuttcp-data     5001/tcp"
	elog "nuttcp6         5000/tcp"
	elog "nuttcp6-data    5001/tcp"
	elog
	einfo "To run nuttcp in server mode, run:"
	einfo "  /etc/init.d/nuttcp start"
}

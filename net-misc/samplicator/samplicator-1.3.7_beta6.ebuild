# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="UDP packets forwarder and duplicator"
HOMEPAGE="http://samplicator.googlecode.com/"
LICENSE="GPL-2"

MY_P=${P/_/-}
SRC_URI="http://samplicator.googlecode.com/files/${MY_P}.tar.gz"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	# Add samplicator group to system
	enewgroup samplicator
	# Add samplicator user to system
	enewuser samplicator -1 -1 /etc/samplicator samplicator
}

src_compile() {
	default
}

src_install() {
	emake DESTDIR="${D}" install
	# Install changelog
	dodoc AUTHORS ChangeLog INSTALL NEWS README
	# Install Gentoo init script
	newinitd "${FILESDIR}"/samplicator.initd samplicator
	# Install Gentoo init script config
	newconfd "${FILESDIR}"/samplicator.conf samplicator
	# Install manual page
	doman "${FILESDIR}"/samplicator.8
}

pkg_postinst() {
	ewarn " Don't specify receiver on the command line, because it will get all packets."
	ewarn " Instead this, specify it in config file. Receiver defined is such way will get only packets with a matching source."
	einfo " For every receiver type create a file in directory /etc/samplicator (see example below)"
	einfo " and specify path to it in variable CONFIG of corresponding initscript config file in /etc/conf.d/"
	einfo " Receiver config examples: "
	einfo " /etc/samplicator/netflow:"
	einfo " 10.0.0.0/255.0.0.0:1.1.1.1/9996 2.2.2.2/9996 3.3.3.3/9996"
	einfo " /etc/samplicator/syslog:"
	einfo " 10.0.0.0/255.255.0.0:2.2.2.2/514 3.3.3.3/514"
	einfo " /etc/samplicator/snmp:"
	einfo " 10.0.0.0/255.255.255.255:3.3.3.3/162"
}
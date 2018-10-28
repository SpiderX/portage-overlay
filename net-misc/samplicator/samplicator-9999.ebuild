# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/sleinen/${PN}.git"
MY_PV=${PV/_/}
MY_P=${PN}-${MY_PV}

inherit autotools git-r3 systemd user

DESCRIPTION="UDP packets forwarder and duplicator"
HOMEPAGE="https://github.com/sleinen/samplicator"
SRC_URI=""

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

pkg_setup() {
	enewgroup samplicator
	enewuser samplicator -1 -1 /etc/samplicator samplicator
}

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default

	doman "${FILESDIR}"/samplicator.8

	newinitd "${FILESDIR}"/samplicator.initd samplicator
	newconfd "${FILESDIR}"/samplicator.confd samplicator
	systemd_dounit "${FILESDIR}"/samplicator.service
}

pkg_postinst() {
	ewarn ""
	ewarn "Don't specify the receiver on the command line, because it will get all packets."
	ewarn "Instead of this, specify it in a config file; defined in such way it will only get packets with a matching source."
	ewarn ""

	einfo "For every receiver type create a file in directory /etc/samplicator (see example below)"
	einfo "and specify the path to it in variable CONFIG of the corresponding initscript config file in /etc/conf.d/"
	einfo ""
	einfo "Receiver config examples: "
	einfo ""
	einfo "    /etc/samplicator/netflow:"
	einfo "    10.0.0.0/255.0.0.0:1.1.1.1/9996 2.2.2.2/9996 3.3.3.3/9996"
	einfo ""
	einfo "    /etc/samplicator/syslog:"
	einfo "    10.0.0.0/255.255.0.0:2.2.2.2/514 3.3.3.3/514"
	einfo ""
	einfo "    /etc/samplicator/snmp:"
	einfo "    10.0.0.0/255.255.255.255:3.3.3.3/162"
}

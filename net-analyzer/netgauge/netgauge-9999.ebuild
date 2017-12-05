# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit user

DESCRIPTION="Server software for testing internet bandwidth using speedtest.net"
HOMEPAGE="http://www.ookla.com/"
SRC_URI="x86? ( http://install.speedtest.net/ooklaserver/stable/OoklaServer-linux32.tgz )
	amd64? ( http://install.speedtest.net/ooklaserver/stable/OoklaServer-linux64.tgz )"

LICENSE="no-source-code"
SLOT="0"
KEYWORDS=""
IUSE=""

QA_PREBUILT="opt/netgauge/OoklaServer"
QA_PRESTRIPPED="opt/netgauge/OoklaServer"

S="${WORKDIR}"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_install() {
	keepdir /opt/${PN}
	insinto /opt/${PN}
	newins OoklaServer.properties.default OoklaServer.properties
	exeinto /opt/${PN}
	doexe OoklaServer
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	fowners -R ${PN}:${PN} /opt/${PN}
}

pkg_postinst() {
	einfo "Add an entry to /etc/portage/make.conf to prevent Ookla Server's config overwriting within next ebuild re-emerge:"
	einfo "		CONFIG_PROTECT='\${CONFIG_PROTECT} /opt/netgauge/OoklaServer.properties'"
}

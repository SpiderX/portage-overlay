# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit user

DESCRIPTION="Server software for testing internet bandwidth using speedtest.net"
HOMEPAGE="http://www.ookla.com/"
SRC_URI="http://cdn.speedtest.speedtest.net/${PN}/Linux.tgz"

LICENSE="no-source-code"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_install() {
	insinto /opt/${PN}
	newins OoklaServer.properties.default OoklaServer.properties
	exeinto /opt/${PN}
	doexe OoklaServer
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	fowners -R ${PN}:${PN} /opt/${PN}
}

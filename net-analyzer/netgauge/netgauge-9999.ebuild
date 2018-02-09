# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit readme.gentoo-r1 user

DESCRIPTION="Server software for testing internet bandwidth using speedtest.net"
HOMEPAGE="http://www.ookla.com/"
SRC_URI="x86? ( http://install.speedtest.net/ooklaserver/stable/OoklaServer-linux32.tgz )
	amd64? ( http://install.speedtest.net/ooklaserver/stable/OoklaServer-linux64.tgz )"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS=""
IUSE=""

S="${WORKDIR}"

QA_PREBUILT="opt/netgauge/OoklaServer"
QA_PRESTRIPPED="opt/netgauge/OoklaServer"

DOC_CONTENTS="Add an entry to /etc/portage/make.conf to prevent Ookla Server's
config overwriting within next ebuild re-emerge:\n
\tCONFIG_PROTECT='\${CONFIG_PROTECT} /opt/netgauge/OoklaServer.properties'"

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
	fowners -R ${PN}:${PN} /opt/${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}

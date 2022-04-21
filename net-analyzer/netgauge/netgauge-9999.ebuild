# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit readme.gentoo-r1 systemd

DESCRIPTION="Server software for testing internet bandwidth using speedtest.net"
HOMEPAGE="https://www.ookla.com"
SRC_URI="x86? ( https://install.speedtest.net/ooklaserver/stable/OoklaServer-linux32.tgz )
	amd64? ( https://install.speedtest.net/ooklaserver/stable/OoklaServer-linux64.tgz )"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="acct-user/netgauge"

S="${WORKDIR}"

QA_PREBUILT="opt/netgauge/OoklaServer"

DOC_CONTENTS="Add an entry to /etc/portage/make.conf to prevent Ookla Server's
config overwriting within next ebuild re-emerge:\\n
\\tCONFIG_PROTECT='\${CONFIG_PROTECT} /opt/netgauge/OoklaServer.properties'"

src_install() {
	insopts -o netgauge -g netgauge -m 0644
	insinto /opt/netgauge
	newins OoklaServer.properties.default OoklaServer.properties
	exeinto /opt/netgauge
	doexe OoklaServer
	newinitd "${FILESDIR}"/netgauge.initd netgauge
	newconfd "${FILESDIR}"/netgauge.confd netgauge
	systemd_dounit "${FILESDIR}"/netgauge.service

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}

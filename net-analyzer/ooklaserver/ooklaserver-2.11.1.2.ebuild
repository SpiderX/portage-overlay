# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Server software for testing internet bandwidth using speedtest.net"
HOMEPAGE="https://www.ookla.com"
SRC_URI="amd64? ( https://install.speedtest.net/ooklaserver/stable/OoklaServer-linux-x86_64-static-musl.tgz )
	arm64? ( https://install.speedtest.net/ooklaserver/stable/OoklaServer-linux-aarch64-static-musl.tgz )"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RDEPEND="acct-group/ookla
	acct-user/ookla"

QA_PREBUILT="opt/ookla/OoklaServer"

src_install() {
	insopts -o ookla -g ookla -m 0644
	insinto /opt/ookla
	doins OoklaServer.properties.default
	exeinto /opt/ookla
	doexe OoklaServer
	newinitd "${FILESDIR}"/ooklaserver.initd ooklaserver
	newconfd "${FILESDIR}"/ooklaserver.confd ooklaserver
	systemd_dounit "${FILESDIR}"/ooklaserver.service
}

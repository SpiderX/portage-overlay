# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit fcaps readme.gentoo-r1 systemd

MY_PN="${PN/-bin/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Network-wide ads & trackers blocking DNS server"
HOMEPAGE="https://github.com/AdguardTeam/AdGuardHome"
SRC_URI="amd64? ( https://github.com/AdguardTeam/${MY_PN}/releases/download/v${PV}/${MY_PN}_linux_amd64.tar.gz -> ${MY_P}.tar.gz )
	arm? ( https://github.com/AdguardTeam/${MY_PN}/releases/download/v${PV}/${MY_PN}_linux_armv6.tar.gz -> ${MY_P}.tar.gz )
	arm64? ( https://github.com/AdguardTeam/${MY_PN}/releases/download/v${PV}/${MY_PN}_linux_arm64.tar.gz -> ${MY_P}.tar.gz )
	x86? ( https://github.com/AdguardTeam/${MY_PN}/releases/download/v${PV}/${MY_PN}_linux_386.tar.gz -> ${MY_P}.tar.gz )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="acct-user/adguardhome"

S="${WORKDIR}/${MY_PN}"

DOCS=( {CHANGELOG,README}.md )
QA_FLAGS_IGNORED="usr/bin/AdGuardHome"
QA_PREBUILT="usr/bin/AdGuardHome"
FILECAPS=( 'cap_net_bind_service=+eip cap_net_raw=+eip' usr/bin/AdGuardHome )
DOC_CONTENTS="Credentials to access WebUI are admin:admin\\n
You may need to review /etc/adguardhome/AdGuardHome.yaml\\n
Default workdir path is /var/lib/adguardhome\\n
Default WebUI URL is http://localhost:80/\\n\\n"

src_install() {
	einstalldocs
	dobin AdGuardHome
	diropts -o adguardhome -g adguardhome
	keepdir /var/{lib,log}/adguardhome /etc/adguardhome
	insinto /etc/adguardhome
	doins "${FILESDIR}"/AdGuardHome.yaml
	newinitd "${FILESDIR}"/adguardhome.initd adguardhome
	newconfd "${FILESDIR}"/adguardhome.confd adguardhome
	systemd_dounit "${FILESDIR}"/adguardhome.service
	readme.gentoo_create_doc
}

pkg_postinst() {
	fcaps_pkg_postinst
	readme.gentoo_print_elog
}

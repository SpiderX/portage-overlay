# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="SNMP Switch Management Daemon"
HOMEPAGE="https://gitorious.org/ssmd"
SRC_URI="https://gitorious.org/${PN}/${PN}/archive-tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-libs/openssl:0=
	dev-libs/boost:0=
	net-misc/curl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${PN}"

pkg_setup() {
	enewgroup "${PN}"
	enewuser "${PN}" -1 -1 /etc/"${PN}" "${PN}"
}

src_compile() {
	if use debug; then
		# Pointless, but makes repoman happy:)
		use debug && MAKEOPTS="-j1"
		emake BUILD=Debug
	else
		emake
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${D}" install
	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
	newconfd "${FILESDIR}"/"${PN}".conf "${PN}"
	fowners -R "${PN}":"${PN}" /etc/"${PN}"/
	fperms 0640 /etc/"${PN}"/"${PN}".conf
}

pkg_postinst() {
	einfo " Data URL format:\\n"
	einfo " <switch ip>,<snmp v2c read community>,<snmp v2c write community>,<switch uplink port>,"
	einfo " <subscriber port>,<subscriber MAC address>,<subscriber download speed>,<subscriber upload speed>,"
	einfo " <subscriber download speed burst>,<subscriber upload speed burst>\\n"
	einfo " Example:\\n"
	einfo " 10.90.90.90,public,private,26,1,0015f2816b7e,10240,10240,1016,1016\\n"
	einfo " Switch ACL profiles:\\n"
	einfo " create access_profile ethernet source_mac FF-FF-FF-FF-FF-FF profile_id N"
	einfo " create access_profile ethernet destination_mac FF-FF-FF-FF-FF-FF profile_id M\\n"
	einfo " In ssmd.conf up_profile_id is N, down_profile_id is M."
}

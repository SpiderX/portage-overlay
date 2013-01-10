# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="SNMP Switch Management Daemon"
HOMEPAGE="https://gitorious.org/ssmd"
SRC_URI="https://gitorious.org/${PN}/${PN}/archive-tarball/${PV} -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"
S="${WORKDIR}/${PN}-${PN}"
MERGE_TYPE="source"

DEPEND="
	dev-libs/openssl
	dev-libs/boost
	net-misc/curl
"

pkg_setup() {
	# Add ssmd group to system
	enewgroup ssmd
	# Add ssmd user to system
	enewuser ssmd -1 -1 /etc/ssmd ssmd
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
	# Call make install
	emake DESTDIR="${D}" PREFIX="${D}" install
	# Install Gentoo init script
	newinitd "${FILESDIR}"/ssmd.initd ssmd
	# Install Gentoo init script config
	newconfd "${FILESDIR}"/ssmd.conf ssmd
	# Correct user and group
	fowners -R ssmd:ssmd /etc/ssmd/
	# Correct permissions
	fperms 0640 /etc/ssmd/ssmd.conf
}

pkg_postinst() {
	einfo " Data URL format:\n"
	einfo " <switch ip>,<snmp v2c read community>,<snmp v2c write community>,<switch uplink port>,"
	einfo " <subscriber port>,<subscriber MAC address>,<subscriber download speed>,<subscriber upload speed>,"
	einfo " <subscriber download speed burst>,<subscriber upload speed burst>\n"
	einfo " Example:\n"
	einfo " 10.90.90.90,public,private,26,1,0015f2816b7e,10240,10240,1016,1016\n"
	einfo " Switch ACL profiles:\n"
	einfo " create access_profile ethernet source_mac FF-FF-FF-FF-FF-FF profile_id N"
	einfo " create access_profile ethernet destination_mac FF-FF-FF-FF-FF-FF profile_id M\n"
	einfo " In ssmd.conf up_profile_id is N, down_profile_id is M."
}

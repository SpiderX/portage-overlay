# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils user linux-info

DESCRIPTION="Open source peer-to-peer VPN"
HOMEPAGE="http://www.peervpn.net/"
MY_P="${PN}-${PV/./-}"
SRC_URI="http://www.peervpn.net/files/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

S=${WORKDIR}/${MY_P}

DEPEND="dev-libs/openssl"
RDEPEND="sys-apps/iproute2
	${DEPEND}"

pkg_setup() {
	# Add peervpn group and user to system
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /etc/${PN} ${PN}

	if use kernel_linux; then
		if ! linux_config_exists; then
			eerror "Unable to check your kernel TUN/TAP device driver support"
		else
			CONFIG_CHECK="~TUN"
			ERROR_TUN="You should enable CONFIG_TUN in kernel"
		fi
	fi
}

src_prepare() {
	# Respect CFLAGS
	sed -i -e '/^CFLAGS+=-O2/s///' Makefile || die 'sed on Makefile failed'

	epatch_user
}

src_install() {
	dosbin peervpn

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}

	# Config files should not be visible to everyone
	insinto /etc/${PN}
	insopts -m600
	doins ${PN}.conf
}

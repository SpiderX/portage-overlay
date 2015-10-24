# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils user

DESCRIPTION="Command line pastebin server"
HOMEPAGE="https://github.com/solusipse/fiche"
SRC_URI="https://github.com/solusipse/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

pkg_setup() {
	# Add fiche group and user to system
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /etc/${PN} ${PN}
}

src_prepare() {
	epatch_user
}

src_install() {
	# Install binary
	dobin ${PN}

	# Create data directory
	diropts -m 755 -o ${PN} -g ${PN}
	keepdir /var/lib/${PN}

	# Install Gentoo init script and its config
	newinitd "${FILESDIR}"/${PN}-0.9.initd ${PN}
	newconfd "${FILESDIR}"/${PN}-0.9.confd ${PN}
}

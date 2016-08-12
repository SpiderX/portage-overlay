# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGIT_REPO_URI="https://github.com/troglobit/${PN}.git"
EGIT_BRANCH="master"

inherit user systemd git-r3

DESCRIPTION="UDP port redirector"
HOMEPAGE="https://github.com/troglobit/${PN}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""
IUSE="systemd"
IUSE="xinetd systemd"
DOCS=( README.md AUTHORS )

RDEPEND="xinetd? ( sys-apps/xinetd )"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_install() {
	default

	use systemd || newinitd "${FILESDIR}"/${PN}.initd ${PN}
	use systemd || newconfd "${FILESDIR}"/${PN}.confd ${PN}
	use systemd && systemd_dounit "${FILESDIR}"/${NAME}.service
}

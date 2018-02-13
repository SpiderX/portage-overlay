# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit user systemd git-r3

DESCRIPTION="UDP port redirector"
HOMEPAGE="https://github.com/troglobit/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/troglobit/${PN}.git"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""
IUSE="xinetd"

RDEPEND="xinetd? ( sys-apps/xinetd )"

DOCS=( README.md AUTHORS )

pkg_setup() {
	enewgroup "${PN}"
	enewuser "${PN}" -1 -1 /dev/null "${PN}"
}

src_install() {
	default

	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
	newconfd "${FILESDIR}"/"${PN}".confd "${PN}"
	systemd_dounit "${FILESDIR}"/"${PN}".service
}

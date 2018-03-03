# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit systemd user

DESCRIPTION="UDP port redirector"
HOMEPAGE="https://github.com/troglobit/uredir"
SRC_URI="https://github.com/troglobit/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

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

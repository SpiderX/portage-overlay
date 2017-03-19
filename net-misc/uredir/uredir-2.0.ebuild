# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit user systemd

DESCRIPTION="UDP port redirector"
HOMEPAGE="https://github.com/troglobit/${PN}"
SRC_URI="https://github.com/troglobit/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"
DOCS=( README.md AUTHORS )

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

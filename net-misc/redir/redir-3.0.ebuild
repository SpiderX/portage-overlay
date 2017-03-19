# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit user systemd

DESCRIPTION="TCP port redirector"
HOMEPAGE="https://github.com/troglobit/${PN}"
SRC_URI="https://github.com/troglobit/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~sparc ~x86"
IUSE="+ftp +shaper systemd tcpd xinetd"
DOCS=( README.md AUTHORS TODO )

RDEPEND="xinetd? ( sys-apps/xinetd )"
DEPEND="tcpd? ( sys-apps/tcp-wrappers )"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_configure() {
	econf $(use_enable shaper shaping) $(use_enable ftp) \
		$(use_with tcpd libwrap)
}

src_install() {
	default

	use systemd || newinitd "${FILESDIR}"/${PN}.initd ${PN}
	use systemd || newconfd "${FILESDIR}"/${PN}.confd ${PN}
	use systemd && systemd_dounit "${FILESDIR}"/${NAME}.service
}

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit systemd user

DESCRIPTION="TCP port redirector"
HOMEPAGE="https://github.com/troglobit/redir"
SRC_URI="https://github.com/troglobit/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ftp +shaper tcpd xinetd"

RDEPEND="xinetd? ( sys-apps/xinetd )"
DEPEND="tcpd? ( sys-apps/tcp-wrappers )"

DOCS=( README.md AUTHORS TODO )

pkg_setup() {
	enewgroup "${PN}"
	enewuser "${PN}" -1 -1 /dev/null "${PN}"
}

src_configure() {
	econf "$(use_enable shaper shaping)" "$(use_enable ftp)" \
		"$(use_with tcpd libwrap)"
}

src_install() {
	default

	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
	newconfd "${FILESDIR}"/"${PN}".confd "${PN}"
	systemd_dounit "${FILESDIR}"/"${NAME}".service
}

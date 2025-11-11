# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd tmpfiles

DESCRIPTION="UDP port redirector"
HOMEPAGE="https://github.com/troglobit/uredir"
SRC_URI="https://github.com/troglobit/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="acct-group/uredir
	acct-user/uredir
	dev-libs/libuev"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_install() {
	default

	newinitd "${FILESDIR}"/uredir.initd uredir
	newconfd "${FILESDIR}"/uredir.confd uredir
	systemd_dounit "${FILESDIR}"/uredir.service
	newtmpfiles "${FILESDIR}"/uredir.tmpfile uredir.conf
}

pkg_postinst() {
	tmpfiles_process uredir.conf
}

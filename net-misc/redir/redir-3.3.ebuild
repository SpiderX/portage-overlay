# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd tmpfiles

DESCRIPTION="TCP port redirector"
HOMEPAGE="https://github.com/troglobit/redir"
SRC_URI="https://github.com/troglobit/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ftp +shaper tcpd xinetd"

RDEPEND="acct-user/redir
	xinetd? ( sys-apps/xinetd )"
DEPEND="tcpd? ( sys-apps/tcp-wrappers )"

DOCS=( {ChangeLog,README}.md TODO transproxy.txt )

src_configure() {
	econf "$(use_enable shaper shaping)" "$(use_enable ftp)" \
		"$(use_with tcpd libwrap)"
}

src_install() {
	default

	newinitd "${FILESDIR}"/redir.initd redir
	newconfd "${FILESDIR}"/redir.confd redir
	systemd_dounit "${FILESDIR}"/redir.service
	newtmpfiles "${FILESDIR}"/redir.tmpfile redir.conf
}

pkg_postinst() {
	tmpfiles_process redir.conf
}

# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/troglobit/${PN}.git"

inherit autotools git-r3 systemd tmpfiles user

DESCRIPTION="TCP port redirector"
HOMEPAGE="https://github.com/troglobit/redir"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+ftp +shaper tcpd xinetd"

RDEPEND="xinetd? ( sys-apps/xinetd )"
DEPEND="tcpd? ( sys-apps/tcp-wrappers )"

DOCS=( README.md AUTHORS TODO )

pkg_setup() {
	enewgroup redir
	enewuser redir -1 -1 /dev/null redir
}

src_prepare() {
	default
	eautoreconf
}

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

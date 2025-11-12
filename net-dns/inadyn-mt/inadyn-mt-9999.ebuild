# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools systemd subversion tmpfiles

DESCRIPTION="A simple dynamic DNS client"
HOMEPAGE="https://sourceforge.net/projects/inadyn-mt/"
ESVN_REPO_URI="https://svn.code.sf.net/p/inadyn-mt/svn/trunk"

LICENSE="GPL-3"
SLOT="0"
IUSE="debug sound"

DEPEND="sound? ( media-libs/libao )"
RDEPEND="acct-group/inadyn
	acct-user/inadyn
	${DEPEND}"

DOCS=( ChangeLog README )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf "$(use_enable debug)" "$(use_enable sound)"
}

src_install() {
	emake INSTALL_PREFIX="${D}"/usr/share DESTDIR="${D}" install

	newinitd "${FILESDIR}"/inadyn-mt.initd inadyn-mt
	newconfd "${FILESDIR}"/inadyn-mt.confd inadyn-mt
	systemd_dounit "${FILESDIR}"/inadyn-mt.service
	newtmpfiles "${FILESDIR}"/inadyn-mt.tmpfile inadyn-mt.conf
}

pkg_postinst() {
	tmpfiles_process inadyn-mt.conf
}

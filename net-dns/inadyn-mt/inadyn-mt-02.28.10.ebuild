# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd tmpfiles

MY_P="${PN}.v.${PV}"

DESCRIPTION="A simple dynamic DNS client"
HOMEPAGE="https://sourceforge.net/projects/inadyn-mt/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug sound"

RDEPEND="acct-user/inadyn"
DEPEND="sound? ( media-libs/libao )"

S="${WORKDIR}/${MY_P}"

DOCS=( ChangeLog NEWS README NOTICE AUTHORS )

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

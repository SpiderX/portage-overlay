# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit user systemd

MY_P="${PN}.v.${PV}"

DESCRIPTION="A simple dynamic DNS client"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug sound systemd"

DEPEND="sound? ( media-libs/libao )"

S="${WORKDIR}/${MY_P}"

DOCS=( ChangeLog NEWS README NOTICE AUTHORS )

pkg_setup() {
	enewgroup "${PN}"
	enewuser "${PN}" -1 -1 /etc/"${PN}" "${PN}"
}

src_configure() {
	econf "$(use_enable debug)" "$(use_enable sound)"
}

src_install() {
	emake INSTALL_PREFIX="${D}"/usr/share DESTDIR="${D}" install

	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
	newconfd "${FILESDIR}"/"${PN}".confd "${PN}"
	systemd_dounit "${FILESDIR}"/"${NAME}".service
}

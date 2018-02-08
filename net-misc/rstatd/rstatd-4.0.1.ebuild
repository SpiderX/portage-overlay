# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_P="rpc.${PN}-${PV}"

inherit systemd

DESCRIPTION="Client-server linux performance statistics"
HOMEPAGE="http://rstatd.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug xinetd"

RDEPEND="net-nds/rpcbind
	xinetd? ( sys-apps/xinetd )"

S="${WORKDIR}/${MY_P}"

PATCHES=( # Add support for new kernels
	"${FILESDIR}"/${P}-new-kernels-support.patch
	# Use debug logging only with debug build
	"${FILESDIR}"/${P}-debug.patch )

src_configure() {
	econf $(use_enable debug)
}

src_install() {
	default

	emake DESTDIR="${D}" install-man
	systemd_dounit "${FILESDIR}"/${PN}.service
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}"/${PN}.xinetd ${PN}
	fi
}

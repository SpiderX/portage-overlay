# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

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
	"${FILESDIR}"/"${P}"-new-kernels-support.patch
	# Use debug logging only with debug build
	"${FILESDIR}"/"${P}"-debug.patch )

src_configure() {
	econf "$(use_enable debug)"
}

src_install() {
	default

	emake DESTDIR="${D}" install-man
	systemd_dounit "${FILESDIR}"/rstatd.service
	newinitd "${FILESDIR}"/rstatd.initd rstatd
	newconfd "${FILESDIR}"/rstatd.confd rstatd

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}"/rstatd.xinetd rstatd
	fi
}

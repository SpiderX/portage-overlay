# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools systemd

MY_P="rpc.${PN}-${PV}"

DESCRIPTION="Client-server linux performance statistics"
HOMEPAGE="http://rstatd.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug xinetd"

RDEPEND="net-nds/rpcbind
	xinetd? ( sys-apps/xinetd )"
DEPEND="${RDEPEND}
	net-libs/rpcsvc-proto"

PATCHES=( # Add support for new kernels
	"${FILESDIR}"/"${P}"-new-kernels-support.patch
	# Use debug logging only with debug build
	"${FILESDIR}"/"${P}"-debug.patch )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf "$(use_enable debug)" CPPFLAGS="-I/usr/include/tirpc"
}

src_compile() {
	emake LDFLAGS="-ltirpc ${LDFLAGS}"
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
